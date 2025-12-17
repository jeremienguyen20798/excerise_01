import 'dart:developer';

import 'package:excerise_01/domain/usecase/delete_alarms_usecase.dart';
import 'package:excerise_01/domain/usecase/get_alarms_usecase.dart';
import 'package:excerise_01/domain/usecase/update_alarm_status_usecase.dart';
import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/notification/alarm_notification.dart';
import '../../../domain/usecase/update_alarm_usecase.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AlarmNotification _alarmNotification = AlarmNotification();
  List<int> _itemDeleteIds = [];

  HomeBloc() : super(InitHomeState()) {
    on<ItemAlarmLongPressEvent>(_onLongPressItem);
    on<OnRestartEvent>(_onRestart);
    on<OnReloadAlarmListEvent>(_onReloadAlarmList);
    on<CancelDeleteAllItemsEvent>(_cancelDeleteAllItems);
    on<AddItemForDeleteEvent>(_addItemDelete);
    on<GetAlarmListEvent>(_getAlarmList);
    on<UpdateAlarmStatusEvent>(_updateAlarmStatus);
    on<UpdateAlarmEvent>(_updateAlarm);
    on<UpdateItemForListEvent>(_updateItemForList);
    on<DeleteAlarmEvent>(_onDeleteAlarm);
    on<DeleteAllAlarmsEvent>(_onDeleteAllAlarms);
    on<RequestNotificationPermissionEvent>(_requestNotificationPermission);
  }

  //Lấy ra danh sách các báo thức
  Future<void> _getAlarmList(
    GetAlarmListEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final dataList = await GetAlarmsUseCase().execute();
    emitter(GetAlarmListState(dataList));
  }

  //Xử lý khi long press item alarm thì hiện UI chọn một hoặc nhiều item để xoá
  void _onLongPressItem(
    ItemAlarmLongPressEvent event,
    Emitter<HomeState> emitter,
  ) {
    emitter(ItemAlarmLongPressState());
  }

  //Đưa mọi thứ trở về trạng thái ban đầu
  void _onRestart(OnRestartEvent event, Emitter<HomeState> emitter) {
    _itemDeleteIds = [];
    emitter(OnRestartState());
  }

  //Them các item vào danh sách để xoá
  void _addItemDelete(AddItemForDeleteEvent event, Emitter<HomeState> emitter) {
    _itemDeleteIds.add(event.id);
    emitter(AddItemForDeleteState());
  }

  //Xoá các item alarm
  Future<void> _onDeleteAlarm(
    DeleteAlarmEvent event,
    Emitter<HomeState> emitter,
  ) async {
    if (_itemDeleteIds.isEmpty) {
      EasyLoading.showToast('Không có báo thức nào để xóa');
    } else {
      await DeleteAlarmsUseCase().execute(_itemDeleteIds);
      await _alarmNotification.cancelAllAlarmRing();
      final dataList = await GetAlarmsUseCase().execute();
      _itemDeleteIds = [];
      emitter(DeleteAlarmState(dataList));
    }
  }

  //Add all items alarm into blacklist
  Future<void> _onDeleteAllAlarms(
    DeleteAllAlarmsEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final alarms = await GetAlarmsUseCase().execute();
    if (alarms.isNotEmpty) {
      _itemDeleteIds = alarms.map((item) => item.alarmId).toList();
      emitter(DeleteAllAlarmsState(true));
    }
  }

  //Cập nhật nhanh trạng thái của báo thức
  Future<void> _updateAlarmStatus(
    UpdateAlarmStatusEvent event,
    Emitter<HomeState> emitter,
  ) async {
    int id = event.id;
    bool isActive = event.isActive;
    UpdateAlarmStatusUseCase().execute(id, isActive);
    // if (event.option == null) {
    //   if (alarm != null) {
    //     if (isActive) {
    //       await _alarmNotification.showNotification(alarm);
    //     } else {
    //       await _alarmNotification.cancelAlarmRingById(id);
    //     }
    //   }
    // } else {
    //   String cancelOption = event.option!;
    //   if (cancelOption == "cancel") {
    //     if (alarm != null) {
    //       if (isActive) {
    //         await _alarmNotification.showNotification(alarm);
    //       } else {
    //         await _alarmNotification.cancelAlarmRingById(id);
    //       }
    //     }
    //   } else {
    //     log('Tính năng đang được phát triển');
    //   }
    // }
  }

  //Cập nhật nội dung chi tiết của báo thức
  Future<void> _updateAlarm(
    UpdateAlarmEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final int index = event.index;
    final data = event.data;
    final idAlarm = data['id'];
    final dateTime = data['dateTime'];
    final isActive = data['isActive'];
    log("Data update: $dateTime - $isActive");
    final alarm = await UpdateAlarmUseCase().execute(
      idAlarm,
      dateTime: dateTime,
      isActive: isActive,
    );
    if (alarm != null) {
      // if (isActive) {
      //   await _alarmNotification.showNotification(alarm);
      // } else {
      //   await _alarmNotification.cancelAlarmRingById(idAlarm);
      // }
      final state = UpdateItemState(index, alarm);
      emitter(state);
    }
  }

  //Reload danh sách báo thức khi có thêm mới item
  void _onReloadAlarmList(
    OnReloadAlarmListEvent event,
    Emitter<HomeState> emitter,
  ) {
    emitter(ReloadAlarmListState(event.alarm));
  }

  //Cập nhật dữ liệu item báo thức
  Future<void> _updateItemForList(
    UpdateItemForListEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final int index = event.index;
    await _alarmNotification.showNotification(event.alarm);
    emitter(UpdateItemForListState(index, event.alarm));
  }

  //Huỷ việc xoá tất cả item báo thức
  void _cancelDeleteAllItems(
    CancelDeleteAllItemsEvent event,
    Emitter<HomeState> emitter,
  ) {
    _itemDeleteIds = [];
    emitter(CancelDeleteAllItemsState());
  }

  //Xử lý UI khi xin quyền hiện thông báo
  Future<void> _requestNotificationPermission(
    RequestNotificationPermissionEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final result = await Permission.notification.request();
    if (result.isDenied || result.isPermanentlyDenied) {
      emitter(DeniedNotificationPermissionRequestState());
    }
  }
}
