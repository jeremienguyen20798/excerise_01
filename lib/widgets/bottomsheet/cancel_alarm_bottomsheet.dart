import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CancelAlarmBottomSheet extends StatefulWidget {
  final AlarmEntity alarm;

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
              context.pop("pause");
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
              context.pop("cancel");
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
              context.pop();
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
