import 'package:equatable/equatable.dart';
import 'package:excerise_01/domain/entities/ringtone_entity.dart';

abstract class RingtoneState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RingtoneInitial extends RingtoneState {}

class LoadRingtoneListState extends RingtoneState {
  final List<RingtoneEntity> ringtones;

  LoadRingtoneListState(this.ringtones);

  @override
  List<Object?> get props => [ringtones];
}