import 'package:excerise_01/domain/entities/ringtone_entity.dart';
import 'package:flutter/material.dart';

class ItemRingtone extends StatelessWidget {
  final RingtoneEntity entity;
  final Function(String) onClicked;

  const ItemRingtone({
    super.key,
    required this.entity,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onClicked(entity.url);
      },
      title: Text(
        entity.name,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.headphones, size: 16.0),
          SizedBox(width: 3.0),
          Text(
            entity.numberOfListens.toString(),
            style: TextStyle(color: Colors.black, fontSize: 14.0),
          ),
          SizedBox(width: 24.0),
          Icon(Icons.cloud_download, size: 16.0, color: Colors.blueAccent),
          SizedBox(width: 3.0),
          Text(
            'Tải nhạc',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
