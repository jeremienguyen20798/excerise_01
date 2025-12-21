import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/core/extensions/alarm_repeat_ext.dart';
import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/widgets/items/item_repeat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/alarm_repeat_type.dart';

class RepeatPage extends StatefulWidget {
  final AlarmRepeatType? alarmRepeatType;
  final List<int>? days;

  const RepeatPage({super.key, required this.alarmRepeatType, this.days});

  @override
  State<RepeatPage> createState() => _RepeatPageState();
}

class _RepeatPageState extends State<RepeatPage> {
  AlarmRepeatType? _alarmRepeatType;
  List<int> _customDays = [];

  List<AlarmRepeatType> alarmRepeatTypes = [
    AlarmRepeatType.onlyOnce,
    AlarmRepeatType.daily,
    AlarmRepeatType.mondayToFriday,
    AlarmRepeatType.custom,
  ];

  @override
  void initState() {
    _alarmRepeatType = widget.alarmRepeatType ?? AlarmRepeatType.onlyOnce;
    _customDays = widget.days ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.pop({"repeatType": _alarmRepeatType, "days": _customDays});
          },
          icon: Icon(Icons.arrow_back),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          repeat,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: alarmRepeatTypes.length,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (BuildContext context, int index) {
          return ItemRepeat(
            alarmRepeatType: alarmRepeatTypes[index],
            isItemSelected: _alarmRepeatType == alarmRepeatTypes[index],
            onClick: (repeatType) async {
              if (repeatType != AlarmRepeatType.custom) {
                _alarmRepeatType = repeatType;
                _customDays = repeatType.getDays();
              } else {
                final days =
                    await AppUtils.showCustomRepeatTypeBottomSheet(
                      context,
                      _customDays,
                    ) ??
                    [];
                if (days.isEmpty) {
                  _alarmRepeatType = AlarmRepeatType.onlyOnce;
                  _customDays = _alarmRepeatType!.getDays();
                } else {
                  if (days.length == 7 && _isAllDays(days)) {
                    _alarmRepeatType = AlarmRepeatType.daily;
                    _customDays = _alarmRepeatType!.getDays();
                  } else if (days.length == 5 && _isMondayToFriday(days)) {
                    _alarmRepeatType = AlarmRepeatType.mondayToFriday;
                    _customDays = _alarmRepeatType!.getDays();
                  } else {
                    _alarmRepeatType = repeatType;
                    _customDays = days;
                  }
                }
              }
              setState(() {});
            },
          );
        },
      ),
    );
  }

  // Thêm 2 hàm hỗ trợ so sánh ngày
  bool _isAllDays(List<int> days) {
    final allDays = [
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday,
      DateTime.sunday,
    ];
    if (days.length != 7) return false;
    return allDays.every((day) => days.contains(day));
  }

  bool _isMondayToFriday(List<int> days) {
    final workDays = [
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
    ];
    if (days.length != 5) return false;
    return workDays.every((day) => days.contains(day));
  }
}
