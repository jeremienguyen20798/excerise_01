import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddLabelBottomSheet extends StatefulWidget {
  final String? label;
  const AddLabelBottomSheet(this.label, {super.key});

  @override
  State<AddLabelBottomSheet> createState() => _AddLabelBottomSheetState();
}

class _AddLabelBottomSheetState extends State<AddLabelBottomSheet> {
  TextEditingController labelController = TextEditingController();

  @override
  void initState() {
    if (widget.label != null && widget.label != 'labelInput'.tr()) {
      labelController.text = widget.label!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy chiều cao của bàn phím ảo (nếu có)
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding,
      ), // <-- SỬ DỤNG CHIỀU CAO KEYBOARD
      child: Container(
        width: MediaQuery.of(context).size.width - 12 * 2,
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'addAlarmLabel'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.0),
            TextField(
              controller: labelController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'labelInput'.tr(),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      context.pop();
                    },
                    height: 48.0,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.grey.shade100,
                    child: Text(
                      'cancel'.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      context.pop(labelController.text);
                    },
                    height: 48.0,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.deepPurple,
                    child: Text(
                      'add'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
