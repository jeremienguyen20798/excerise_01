import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'defaultEmptyText'.tr(),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                text: "${'defaultSubEmptyText'.tr()}\n",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
                children: [
                  TextSpan(
                    text: 'Trích dẫn: ',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                  TextSpan(
                    text: "Gemini AI",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
