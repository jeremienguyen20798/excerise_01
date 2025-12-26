import 'package:easy_localization/easy_localization.dart';
import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_bloc.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_state.dart';
import 'package:excerise_01/widgets/compoment/alarm_ringtone_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RingtoneView extends StatelessWidget {
  const RingtoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RingtoneBloc, RingtoneState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'ringtoneTitle'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [Expanded(child: AlarmRingtoneList())],
          ),
        );
      },
      listener: (context, state) {
        if (state is PlayRingtoneState) {
          final String ringtoneUrl = state.url;
          final String name = state.name;
          AppUtils.showPlayRingtoneDialog(context, name, ringtoneUrl);
        }
      },
    );
  }
}
