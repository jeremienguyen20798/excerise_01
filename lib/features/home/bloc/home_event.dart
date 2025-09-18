import 'package:excerise_01/entities/alarm.dart';

abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class GetAlarmListEvent extends HomeEvent {}

class UpdateAlarmStatusEvent extends HomeEvent {
  int id;
  bool isActive;

  UpdateAlarmStatusEvent(this.id, this.isActive);
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
  Map<String, dynamic> data;

  UpdateAlarmEvent(this.data);
}

class OnReloadAlarmListEvent extends HomeEvent {
  Alarm alarm;

  OnReloadAlarmListEvent(this.alarm);
}

class UpdateItemForListEvent extends HomeEvent {
  Alarm alarm;

  UpdateItemForListEvent(this.alarm);
}

class CancelDeleteAllItemsEvent extends HomeEvent {}
