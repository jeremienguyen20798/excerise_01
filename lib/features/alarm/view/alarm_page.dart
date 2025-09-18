import 'package:excerise_01/features/alarm/bloc/alarm_bloc.dart';
import 'package:excerise_01/features/alarm/view/alarm_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/alarm.dart';

class AlarmPage extends StatelessWidget {
  final Alarm? alarm;

  const AlarmPage({super.key, this.alarm});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlarmBloc(),
      child: AlarmView(alarm: alarm),
    );
  }
}
