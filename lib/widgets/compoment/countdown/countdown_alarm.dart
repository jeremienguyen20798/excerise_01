import 'dart:async';

import 'package:excerise_01/core/utils/formatter.dart';
import 'package:excerise_01/widgets/compoment/countdown/countdown_bloc.dart';
import 'package:excerise_01/widgets/compoment/countdown/countdown_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountdownAlarm extends StatefulWidget {
  final String repeatTypeStr;
  final DateTime dateTime;

  const CountdownAlarm({
    super.key,
    required this.repeatTypeStr,
    required this.dateTime,
  });

  @override
  State<CountdownAlarm> createState() => _CountdownAlarmState();
}

class _CountdownAlarmState extends State<CountdownAlarm> {
  Timer? countdownTimer;
  Duration remaining = Duration.zero;
  DateTime? alarmTime; // Thời gian báo thức
  String repeatTypeStr = '';

  @override
  void initState() {
    repeatTypeStr = widget.repeatTypeStr;
    startCountDown(widget.dateTime);
    super.initState();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: repeatTypeStr,
        style: TextStyle(fontSize: 14.0, color: Colors.grey),
        children: [
          TextSpan(text: ' | ', style: TextStyle(fontSize: 16.0)),
          TextSpan(
            text: Formatter.formatTime(remaining),
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  void startCountDown(DateTime dateTime) {
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(Duration(days: 1));
    }
    setState(() {
      alarmTime = dateTime;
      remaining = alarmTime!.difference(DateTime.now());
    });
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        remaining = alarmTime!.difference(DateTime.now());
        if (remaining.isNegative) {
          countdownTimer?.cancel();
          remaining = Duration.zero;
          // 🚨 Kích hoạt báo thức ở đây
          BlocProvider.of<CountdownAlarmBloc>(
            context,
          ).add(RingAlarmEvent(alarmTime!));
        }
      });
    });
  }
}
