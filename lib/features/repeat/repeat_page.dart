import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/widgets/items/item_repeat.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/alarm_repeat_type.dart';

class RepeatPage extends StatefulWidget {
  final AlarmRepeatType? alarmRepeatType;

  const RepeatPage({super.key, required this.alarmRepeatType});

  @override
  State<RepeatPage> createState() => _RepeatPageState();
}

class _RepeatPageState extends State<RepeatPage> {
  AlarmRepeatType? _alarmRepeatType;

  List<AlarmRepeatType> alarmRepeatTypes = [
    AlarmRepeatType.onlyOnce,
    AlarmRepeatType.daily,
    AlarmRepeatType.mondayToFriday,
    AlarmRepeatType.custom,
  ];

  @override
  void initState() {
    _alarmRepeatType = widget.alarmRepeatType ?? AlarmRepeatType.onlyOnce;
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
            Navigator.pop(context, _alarmRepeatType);
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
            onClick: (repeatType) {
              setState(() {
                _alarmRepeatType = repeatType;
              });
            },
          );
        },
      ),
    );
  }
}
