import 'dart:developer';

import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/local_db/alarm_local_db.dart';
import '../../../core/notification/alarm_notification.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AlarmLocalDB localDB = AlarmLocalDB();
  AlarmNotification alarmNotification = AlarmNotification();
  List<int> itemDeleteIds = [];

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
    final dataList = await localDB.getAlarms();
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
    emitter(OnRestartState());
  }

  //Them các item vào danh sách để xoá
  void _addItemDelete(AddItemForDeleteEvent event, Emitter<HomeState> emitter) {
    itemDeleteIds.add(event.id);
    emitter(AddItemForDeleteState());
  }

  //Xoá các item alarm
  Future<void> _onDeleteAlarm(
    DeleteAlarmEvent event,
    Emitter<HomeState> emitter,
  ) async {
    await localDB.deleteAlarms(itemDeleteIds);
    await alarmNotification.cancelAllAlarmRing();
    final dataList = await localDB.getAlarms();
    emitter(DeleteAlarmState(dataList));
  }

  //Xoá tất cả các item alarm
  Future<void> _onDeleteAllAlarms(
    DeleteAllAlarmsEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final alarms = await localDB.getAlarms();
    if (alarms.isNotEmpty) {
      itemDeleteIds = alarms.map((item) => item.id).toList();
      alarmNotification.cancelAllAlarmRing();
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
    await localDB.updateAlarmStatus(id, isActive);
    final alarm = await localDB.getAlarmById(id);
    if (alarm != null) {
      await alarmNotification.showNotification(alarm);
    }
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
    await localDB.updateAlarm(idAlarm, dateTime, isActive);
    final alarm = await localDB.getAlarmById(idAlarm);
    if (alarm != null) {
      await alarmNotification.showNotification(alarm);
      emitter(UpdateItemState(index, alarm));
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
    await alarmNotification.showNotification(event.alarm);
    emitter(UpdateItemForListState(index, event.alarm));
  }

  //Huỷ việc xoá tất cả item báo thức
  void _cancelDeleteAllItems(
    CancelDeleteAllItemsEvent event,
    Emitter<HomeState> emitter,
  ) {
    emitter(CancelDeleteAllItemsState());
  }

  //Yêu cầu xin quyền hiện thông báo
  Future<void> _requestNotificationPermission(
    RequestNotificationPermissionEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final result = await Permission.notification.request();
    if (result.isDenied) {
      openAppSettings();
    }
  }
}
