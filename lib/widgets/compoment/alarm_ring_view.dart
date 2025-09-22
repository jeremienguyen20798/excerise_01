import 'package:flutter/material.dart';

bool isAlarmRing = false;

class AlarmRingView extends StatelessWidget {
  const AlarmRingView({super.key});

  @override
  Widget build(BuildContext context) {
    return isAlarmRing
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.deepPurple,
            ),
            child: ListTile(
              leading: Icon(Icons.notifications_active, color: Colors.white),
              title: Text(
                '02:26',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              subtitle: Text(
                'Đổ chuông',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              trailing: TextButton(
                onPressed: () {},
                child: Text(
                  'Tắt',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
