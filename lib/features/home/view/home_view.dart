import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/features/alarm/view/alarm_page.dart';
import 'package:excerise_01/features/home/bloc/home_bloc.dart';
import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:excerise_01/widgets/compoment/alarm_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isLongPress = false, isDeleteAllItems = false;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ItemAlarmLongPressState) {
          isLongPress = true;
        } else if (state is OnRestartState) {
          isLongPress = false;
          isDeleteAllItems = false;
        } else if (state is DeleteAlarmState) {
          isLongPress = false;
        } else if (state is DeleteAllAlarmsState) {
          isDeleteAllItems = state.isDeleteAll;
        } else if (state is CancelDeleteAllItemsState) {
          isDeleteAllItems = false;
        }
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: isLongPress
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
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                  background: Align(
                    alignment: Alignment.centerRight,
                    child: isLongPress
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
                            onPressed: () {},
                            icon: Icon(Icons.more_vert, color: Colors.black),
                          ),
                  ),
                  title: isLongPress
                      ? Text(
                          chooseItem,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          textAlign: TextAlign.center,
                        )
                      : Text(defaultAppName, style: TextStyle(fontSize: 16.0)),
                ),
                expandedHeight: kToolbarHeight * 2,
              ),
              AlarmList(),
            ],
          ),
          floatingActionButton: isLongPress
              ? null
              : FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AlarmPage()),
                    );
                    BlocProvider.of<HomeBloc>(
                      context,
                    ).add(OnReloadAlarmListEvent(result));
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
                            deleteText,
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
