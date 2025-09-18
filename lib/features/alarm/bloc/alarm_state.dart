import 'package:equatable/equatable.dart';
import 'package:excerise_01/entities/alarm.dart';

abstract class AlarmState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitAlarmState extends AlarmState {}

class AddAlarmState extends AlarmState {
  final Alarm alarm;

  AddAlarmState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

class UpdateAlarmState extends AlarmState {
  final Alarm alarm;

  UpdateAlarmState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}
