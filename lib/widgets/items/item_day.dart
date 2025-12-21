import 'package:excerise_01/core/extensions/day_alarm_ext.dart';
import 'package:flutter/material.dart';

class ItemDay extends StatefulWidget {
  final int day;
  final bool isSelected;
  final Function(int) onAddDay;
  final Function(int) onRemoveDay;

  const ItemDay({
    super.key,
    required this.day,
    required this.onAddDay,
    required this.onRemoveDay,
    required this.isSelected,
  });

  @override
  State<ItemDay> createState() => _ItemDayState();
}

class _ItemDayState extends State<ItemDay> {
  bool isChoose = false;

  @override
  void initState() {
    isChoose = widget.isSelected;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemDay oldWidget) {
    if (oldWidget.isSelected != widget.isSelected) {
      isChoose = widget.isSelected;
    }
    super.didUpdateWidget(oldWidget);
  }

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
