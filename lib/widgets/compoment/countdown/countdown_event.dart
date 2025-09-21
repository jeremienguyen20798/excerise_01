import 'package:excerise_01/entities/alarm.dart';

abstract class CountdownAlarmEvent {}

class GetComingAlarmEvent extends CountdownAlarmEvent {
  final List<Alarm> alarms;

  GetComingAlarmEvent(this.alarms);
}