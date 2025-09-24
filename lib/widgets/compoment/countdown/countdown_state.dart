import 'package:equatable/equatable.dart';

abstract class CountdownAlarmState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends CountdownAlarmState {}

class RingAlarmState extends CountdownAlarmState {
  final DateTime dateTime;

  RingAlarmState(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}