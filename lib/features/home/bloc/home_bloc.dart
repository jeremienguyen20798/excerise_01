import 'dart:developer';

import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/local_db/alarm_local_db.dart';
import '../../../core/notification/alarm_notification.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AlarmLocalDB localDB = AlarmLocalDB();
  AlarmNotification alarmNotification = AlarmNotification();
  List<int> itemDeleteIds = [];

  HomeBloc() : super(InitHomeState()) {
    on<GetAlarmListEvent>(_getAlarmList);
    on<ItemAlarmLongPressEvent>(_onLongPressItem);
    on<OnRestartEvent>(_onRestart);
    on<AddItemForDeleteEvent>(_addItemDelete);
    on<DeleteAlarmEvent>(_onDeleteAlarm);
    on<UpdateAlarmStatusEvent>(_updateAlarmStatus);
    on<UpdateAlarmEvent>(_updateAlarm);
    on<OnReloadAlarmListEvent>(_onReloadAlarmList);
    on<UpdateItemForListEvent>(_updateItemForList);
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

  //Cập nhật nhanh trạng thái của báo thức
  Future<void> _updateAlarmStatus(
    UpdateAlarmStatusEvent event,
    Emitter<HomeState> emitter,
  ) async {
    int id = event.id;
    bool isActive = event.isActive;
    await localDB.updateAlarmStatus(id, isActive);
  }

  //Cập nhật nội dung chi tiết của báo thức
  Future<void> _updateAlarm(
    UpdateAlarmEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final data = event.data;
    final idAlarm = data['id'];
    final dateTime = data['dateTime'];
    final isActive = data['isActive'];
    log("Data update: $dateTime - $isActive");
    await localDB.updateAlarm(idAlarm, dateTime, isActive);
  }

  //Reload danh sách báo thức khi có thêm mới item
  void _onReloadAlarmList(
    OnReloadAlarmListEvent event,
    Emitter<HomeState> emitter,
  ) {
    emitter(ReloadAlarmListState(event.alarm));
  }

  void _updateItemForList(UpdateItemForListEvent event, Emitter<HomeState> emitter) {
    emitter(UpdateItemForListState(event.alarm));
  }
}
