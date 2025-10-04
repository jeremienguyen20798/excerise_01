import 'package:excerise_01/entities/alarm.dart';
import 'package:flutter/material.dart';

class CancelAlarmBottomSheet extends StatefulWidget {
  final Alarm alarm;

  const CancelAlarmBottomSheet({super.key, required this.alarm});

  @override
  State<CancelAlarmBottomSheet> createState() => _CancelAlarmBottomSheetState();
}

class _CancelAlarmBottomSheetState extends State<CancelAlarmBottomSheet> {
  final now = DateTime.now();
  String titleOption = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Tắt báo thức',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          ListTile(
            onTap: () {
              Navigator.pop(context, "pause");
            },
            title: Text(
              titleOption,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          ListTile(
            onTap: () {
              Navigator.pop(context, "cancel");
            },
            title: Text(
              'Tắt lặp lại báo thức này',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.grey.shade100,
            height: 48.0,
            minWidth: MediaQuery.of(context).size.width - 16 * 2,
            elevation: 0.0,
            child: Text(
              'Huỷ',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
