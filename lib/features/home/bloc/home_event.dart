import 'package:excerise_01/domain/entities/alarm_entity.dart';

abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class GetAlarmListEvent extends HomeEvent {}

class UpdateAlarmStatusEvent extends HomeEvent {
  String? option;
  int id;
  bool isActive;

  UpdateAlarmStatusEvent(this.option, this.id, this.isActive);
}

class ItemAlarmLongPressEvent extends HomeEvent {
  AlarmEntity alarmEntity;

  ItemAlarmLongPressEvent(this.alarmEntity);
}

class OnRestartEvent extends HomeEvent {}

class AddItemForDeleteEvent extends HomeEvent {
  int id;

  AddItemForDeleteEvent(this.id);
}

class DeleteAlarmEvent extends HomeEvent {}

class DeleteAllAlarmsEvent extends HomeEvent {}

class UpdateAlarmEvent extends HomeEvent {
  //Vi tri index can update du lieu
  int index;
  Map<String, dynamic> data;

  UpdateAlarmEvent(this.index, this.data);
}

class OnReloadAlarmListEvent extends HomeEvent {
  AlarmEntity alarm;

  OnReloadAlarmListEvent(this.alarm);
}

class UpdateItemForListEvent extends HomeEvent {
  //Vi tri index can update du lieu
  int index;
  AlarmEntity alarm;

  UpdateItemForListEvent(this.index, this.alarm);
}

class CancelDeleteAllItemsEvent extends HomeEvent {}

class RequestNotificationPermissionEvent extends HomeEvent {}

class RemoveItemForDeleteIdsEvent extends HomeEvent {
  int id;

  RemoveItemForDeleteIdsEvent(this.id);
}

class AlarmDismissedFromNotificationEvent extends HomeEvent {
  String alarmData;

  AlarmDismissedFromNotificationEvent(this.alarmData);
}

class DeleteAlarmAfterRingEvent extends HomeEvent {
  AlarmEntity entity;

  DeleteAlarmAfterRingEvent(this.entity);
}
