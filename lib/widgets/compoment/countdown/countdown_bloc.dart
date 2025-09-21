import 'package:excerise_01/widgets/compoment/countdown/countdown_event.dart';
import 'package:excerise_01/widgets/compoment/countdown/countdown_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountdownAlarmBloc
    extends Bloc<CountdownAlarmEvent, CountdownAlarmState> {
  CountdownAlarmBloc() : super(InitialState());
}
