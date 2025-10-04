import 'package:excerise_01/core/extensions/alarm_repeat_ext.dart';
import 'package:excerise_01/entities/alarm_repeat_type.dart';
import 'package:flutter/material.dart';

class ItemRepeat extends StatelessWidget {
  final AlarmRepeatType alarmRepeatType;
  final bool isItemSelected;
  final Function(AlarmRepeatType) onClick;

  const ItemRepeat({
    super.key,
    required this.alarmRepeatType,
    required this.isItemSelected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: isItemSelected ? Colors.blue.shade50 : Colors.grey.shade200,
      ),
      child: ListTile(
        onTap: () {
          onClick(alarmRepeatType);
        },
        leading: isItemSelected
            ? Icon(
                Icons.check,
                color: isItemSelected ? Colors.blue : Colors.black,
              )
            : SizedBox(width: 24.0),
        title: Text(
          alarmRepeatType.getStr(),
          style: TextStyle(
            fontSize: 16.0,
            color: isItemSelected ? Colors.blue : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
