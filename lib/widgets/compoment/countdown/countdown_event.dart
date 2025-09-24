abstract class CountdownAlarmEvent {}

class RingAlarmEvent extends CountdownAlarmEvent {
  final DateTime dateTime;

  RingAlarmEvent(this.dateTime);
}