import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationWarningDialog extends StatelessWidget {
  const NotificationWarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(warningTitle),
      content: RichText(
        text: TextSpan(
          text: permissionStr,
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: notificationStr,
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            TextSpan(text: warningContent),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final isOpened = await openAppSettings();
            if(isOpened) {
              Navigator.pop(context);
            }
          },
          child: Text(settings),
        ),
      ],
    );
  }
}
