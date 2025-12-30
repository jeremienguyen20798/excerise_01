import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:excerise_01/core/utils/formatter.dart';
import 'package:flutter/material.dart';

class CountdownAlarm extends StatefulWidget {
  final String? repeatTypeStr;
  final DateTime dateTime;

  const CountdownAlarm({super.key, this.repeatTypeStr, required this.dateTime});

  @override
  State<CountdownAlarm> createState() => _CountdownAlarmState();
}

class _CountdownAlarmState extends State<CountdownAlarm> {
  Timer? countdownTimer;
  Duration remaining = Duration.zero;
  String? repeatTypeStr;

  @override
  void initState() {
    repeatTypeStr = widget.repeatTypeStr;
    startCountDown(widget.dateTime);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CountdownAlarm oldWidget) {
    if (oldWidget.dateTime != widget.dateTime) {
      startCountDown(widget.dateTime);
    }
    super.didUpdateWidget(oldWidget);
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
        children: repeatTypeStr != null
            ? [
                TextSpan(
                  text: 'defaultSpace1'.tr(),
                  style: TextStyle(fontSize: 16.0),
                ),
                TextSpan(
                  text: Formatter.formatTime(remaining),
                  style: TextStyle(fontSize: 14.0),
                ),
              ]
            : [
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
      int days = DateTime.now().difference(dateTime).inDays;
      log('Days: ${days + 1}');
      dateTime = dateTime.add(Duration(days: days + 1));
    }
    setState(() {
      remaining = dateTime.difference(DateTime.now());
    });
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        remaining = dateTime.difference(DateTime.now());
        if (remaining.isNegative) {
          countdownTimer?.cancel();
          remaining = Duration.zero;
          // 🚨 Kích hoạt báo thức ở đây
        }
      });
    });
  }
}
