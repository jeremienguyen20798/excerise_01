import 'package:easy_localization/easy_localization.dart';
import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/features/alarm/view/alarm_page.dart';
import 'package:excerise_01/features/home/bloc/home_bloc.dart';
import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:excerise_01/widgets/compoment/alarm_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

bool isLongPress = false, isDeleteAllItems = false, isHideButton = false;
ScrollController _scrollController = ScrollController();
int deleteItemsLength = 0;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ItemAlarmLongPressState) {
          isLongPress = true;
          isHideButton = false;
          deleteItemsLength = state.length;
        } else if (state is OnRestartState) {
          isLongPress = false;
          isHideButton = false;
          isDeleteAllItems = false;
        } else if (state is DeleteAlarmState) {
          isLongPress = false;
          isHideButton = false;
        } else if (state is DeleteAllAlarmsState) {
          isDeleteAllItems = state.isDeleteAll;
          deleteItemsLength = state.length;
        } else if (state is CancelDeleteAllItemsState) {
          isDeleteAllItems = false;
          deleteItemsLength = 0;
        } else if (state is RemoveItemForDeleteIdsState) {
          isDeleteAllItems = false;
          deleteItemsLength = state.length;
        } else if (state is AddItemForDeleteState) {
          deleteItemsLength = state.length;
        } else if (state is ScrollOnTopState) {
          isHideButton = true;
        } else if (state is ScrollOnBottomState) {
          isHideButton = false;
        }
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // Lấy vị trí cuộn hiện tại
              final double currentScrollPosition =
                  _scrollController.position.pixels;
              print('Cuộn hiện tại: $currentScrollPosition');
              // So sánh vị trí cuộn hiện tại với vị trí có giá trị nhỏ nhất mà appTitle vào AppBar
              if (currentScrollPosition >= 28.362171519886147) {
                BlocProvider.of<HomeBloc>(context).add(ScrollOnTopEvent());
                // So sánh vị trí cuộn hiện tại với khoảng vị trí thích hợp để làm xuất hiện button close
              } else if (currentScrollPosition <= 28.907581676136658 &&
                  currentScrollPosition >= 13.09019886363484) {
                BlocProvider.of<HomeBloc>(context).add(ScrollOnBottomEvent());
              }
              return true;
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  leading: isHideButton
                      ? null
                      : isLongPress
                      ? IconButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(
                              context,
                            ).add(OnRestartEvent());
                          },
                          icon: Icon(Icons.close),
                        )
                      : null,
                  snap: false,
                  pinned: true,
                  floating: false,
                  backgroundColor: Colors.grey.shade100,
                  actions: [
                    isLongPress
                        ? IconButton(
                            onPressed: () {
                              if (isDeleteAllItems) {
                                BlocProvider.of<HomeBloc>(
                                  context,
                                ).add(CancelDeleteAllItemsEvent());
                              } else {
                                BlocProvider.of<HomeBloc>(
                                  context,
                                ).add(DeleteAllAlarmsEvent());
                              }
                            },
                            icon: Icon(
                              Icons.playlist_add_check,
                              color: isDeleteAllItems
                                  ? Colors.deepPurple
                                  : Colors.black,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              context.go('/settings');
                            },
                            icon: Icon(Icons.more_vert, color: Colors.black),
                          ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                    title: isLongPress
                        ? Text(
                            '${'chooseItem'.tr()}$deleteItemsLength${'item'.tr()}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'defaultAppName'.tr(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                  ),
                  expandedHeight: kToolbarHeight * 2,
                ),
                AlarmList(),
              ],
            ),
          ),
          floatingActionButton: isLongPress
              ? null
              : FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AlarmPage()),
                    );
                    if (result != null) {
                      BlocProvider.of<HomeBloc>(
                        context,
                      ).add(OnReloadAlarmListEvent(result));
                    }
                  },
                  child: const Icon(Icons.add),
                ),
          // This trailing comma makes auto-formatting nicer for build methods.
          persistentFooterButtons: isLongPress
              ? [
                  Center(
                    child: IconButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(
                          context,
                        ).add(DeleteAlarmEvent());
                      },
                      icon: Column(
                        children: [
                          Icon(Icons.delete_outline),
                          Text(
                            'deleteText'.tr(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              : null,
        );
      },
      listener: (BuildContext context, HomeState state) {
        if (state is DeniedNotificationPermissionRequestState) {
          AppUtils.showNotificationWarningDialog(context);
        }
      },
    );
  }
}
