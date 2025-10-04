import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/entities/alarm_repeat_type.dart';
import 'package:excerise_01/widgets/items/item_repeat.dart';
import 'package:flutter/material.dart';

class RepeatPage extends StatefulWidget {
  const RepeatPage({super.key});

  @override
  State<RepeatPage> createState() => _RepeatPageState();
}

class _RepeatPageState extends State<RepeatPage> {
  AlarmRepeatType alarmRepeatType = AlarmRepeatType.onlyOnce;

  List<AlarmRepeatType> alarmRepeatTypes = [
    AlarmRepeatType.onlyOnce,
    AlarmRepeatType.daily,
    AlarmRepeatType.mondayToFriday,
    AlarmRepeatType.custom,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, alarmRepeatType);
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
            isItemSelected: alarmRepeatType == alarmRepeatTypes[index],
            onClick: (repeatType) {
              setState(() {
                alarmRepeatType = repeatType;
              });
            },
          );
        },
      ),
    );
  }
}
