import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            defaultEmptyText,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              text: "$defaultSubEmptyText\n",
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
    );
  }
}
