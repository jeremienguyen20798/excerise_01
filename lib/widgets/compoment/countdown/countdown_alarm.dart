import 'package:flutter/material.dart';

class CountdownAlarm extends StatefulWidget {
  final DateTime dateTime;

  const CountdownAlarm({super.key, required this.dateTime});

  @override
  State<CountdownAlarm> createState() => _CountdownAlarmState();
}

class _CountdownAlarmState extends State<CountdownAlarm> {

  @override
  void initState() {
    final now = DateTime.now();
    final distance = now.difference(widget.dateTime).inMilliseconds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}
