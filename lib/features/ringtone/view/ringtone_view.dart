import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/widgets/compoment/alarm_ringtone_list.dart';
import 'package:flutter/material.dart';

class RingtoneView extends StatelessWidget {
  const RingtoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ringtoneTitle,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [Expanded(child: AlarmRingtoneList())],
      ),
    );
  }
}