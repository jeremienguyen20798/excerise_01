import 'package:equatable/equatable.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';

abstract class AlarmState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitAlarmState extends AlarmState {}

class AddAlarmState extends AlarmState {
  final AlarmEntity alarm;

  AddAlarmState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

class UpdateAlarmState extends AlarmState {
  final AlarmEntity alarm;

  UpdateAlarmState(this.alarm);

  @override
  List<Object?> get props => [alarm];
}

class DateTimeChangedState extends AlarmState {
  final DateTime dateTime;

  DateTimeChangedState(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}
