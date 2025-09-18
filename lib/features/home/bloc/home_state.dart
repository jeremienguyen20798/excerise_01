import 'package:equatable/equatable.dart';
import 'package:excerise_01/entities/alarm.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitHomeState extends HomeState {}

class GetAlarmListState extends HomeState {
  final List<Alarm> alarms;

  GetAlarmListState(this.alarms);

  @override
  List<Object?> get props => [alarms];
}

class ItemAlarmLongPressState extends HomeState {}

class OnRestartState extends HomeState {}

class AddItemForDeleteState extends HomeState {}

class DeleteAlarmState extends HomeState {
  final List<Alarm> alarms;

  DeleteAlarmState(this.alarms);

  @override
  List<Object?> get props => [alarms];
}

class ReloadAlarmListState extends HomeState {
  final Alarm alarm;

  ReloadAlarmListState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

class UpdateItemForListState extends HomeState {
  final Alarm alarm;

  UpdateItemForListState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}
