import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/widgets/items/item_day.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomRepeatTypeBottomSheet extends StatefulWidget {
  final List<int>? days;

  const CustomRepeatTypeBottomSheet({super.key, this.days});

  @override
  State<CustomRepeatTypeBottomSheet> createState() =>
      _CustomRepeatTypeBottomSheetState();
}

class _CustomRepeatTypeBottomSheetState
    extends State<CustomRepeatTypeBottomSheet> {
  List<int> days = [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
  ];
  List<int> alarmDays = [];

  @override
  void initState() {
    alarmDays = widget.days ?? [];
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomRepeatTypeBottomSheet oldWidget) {
    if (oldWidget.days != widget.days) {
      setState(() {
        alarmDays = widget.days ?? [];
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
            child: Text(
              customText,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            itemBuilder: (context, index) => ItemDay(
              day: days[index],
              isSelected: alarmDays.contains(days[index]),
              onAddDay: (value) {
                setState(() {
                  alarmDays.add(value);
                });
              },
              onRemoveDay: (value) {
                setState(() {
                  alarmDays.remove(value);
                });
              },
            ),
            itemCount: days.length,
            shrinkWrap: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      context.pop();
                    },
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.grey.shade200,
                    height: 48.0,
                    child: Text(
                      cancel,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      context.pop(alarmDays);
                    },
                    elevation: 0.0,
                    height: 48.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      ok,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
