import 'package:excerise_01/features/ringtone/bloc/ringtone_event.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RingtoneBloc extends Bloc<RingtoneEvent, RingtoneState>{

  RingtoneBloc() : super(RingtoneInitial());
}