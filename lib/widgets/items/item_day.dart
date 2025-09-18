import 'package:flutter/material.dart';

class ItemDay extends StatelessWidget {
  final String title;

  const ItemDay({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Checkbox(value: false, onChanged: (value) {}),
    );
  }
}
