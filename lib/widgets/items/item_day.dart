import 'package:excerise_01/core/extensions/day_alarm_ext.dart';
import 'package:flutter/material.dart';

class ItemDay extends StatefulWidget {
  final int day;
  final Function(int) onAddDay;
  final Function(int) onRemoveDay;

  const ItemDay({
    super.key,
    required this.day,
    required this.onAddDay,
    required this.onRemoveDay,
  });

  @override
  State<ItemDay> createState() => _ItemDayState();
}

class _ItemDayState extends State<ItemDay> {
  bool isChoose = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.day.getTitle(),
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Checkbox(
        value: isChoose,
        onChanged: (value) {
          setState(() {
            isChoose = value ?? false;
            if (isChoose) {
              widget.onAddDay(widget.day);
            } else {
              widget.onRemoveDay(widget.day);
            }
          });
        },
      ),
    );
  }
}
