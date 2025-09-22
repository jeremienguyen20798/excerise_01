import 'package:excerise_01/entities/alarm.dart';

abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class GetAlarmListEvent extends HomeEvent {}

class UpdateAlarmStatusEvent extends HomeEvent {
  String? option;
  int id;
  bool isActive;

  UpdateAlarmStatusEvent(this.option, this.id, this.isActive);
}

class ItemAlarmLongPressEvent extends HomeEvent {}

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
  Alarm alarm;

  OnReloadAlarmListEvent(this.alarm);
}

class UpdateItemForListEvent extends HomeEvent {
  //Vi tri index can update du lieu
  int index;
  Alarm alarm;

  UpdateItemForListEvent(this.index, this.alarm);
}

class CancelDeleteAllItemsEvent extends HomeEvent {}

class RequestNotificationPermissionEvent extends HomeEvent {}
