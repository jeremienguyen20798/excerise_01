import 'package:excerise_01/features/ringtone/bloc/ringtone_bloc.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_event.dart';
import 'package:excerise_01/features/ringtone/view/ringtone_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RingtonePage extends StatelessWidget {
  const RingtonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RingtoneBloc()..add(LoadingRingtoneListEvent()),
      child: RingtoneView(),
    );
  }
}
