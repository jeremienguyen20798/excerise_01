import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationWarningDialog extends StatelessWidget {
  const NotificationWarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('warningTitle'.tr()),
      content: RichText(
        text: TextSpan(
          text: 'permissionStr'.tr(),
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'notificationStr'.tr(),
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            TextSpan(text: 'warningContent'.tr()),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final isOpened = await openAppSettings();
            if (isOpened) {
              context.pop();
            }
          },
          child: Text('settings'.tr()),
        ),
      ],
    );
  }
}
