import 'package:excerise_01/entities/alarm_repeat_type.dart';

abstract class AlarmEvent {}

class AddAlarmEvent extends AlarmEvent {
  DateTime dateTime;
  String? message;
  AlarmRepeatType? repeatType;
  List<int>? days;

  AddAlarmEvent({
    required this.dateTime,
    this.message,
    this.repeatType,
    this.days,
  });
}

class UpdateAlarmEvent extends AlarmEvent {
  int id;
  DateTime dateTime;
  String? message;
  AlarmRepeatType? repeatType;
  List<int>? days;

  UpdateAlarmEvent({
    required this.id,
    required this.dateTime,
    this.message,
    this.repeatType,
    this.days,
  });
}
