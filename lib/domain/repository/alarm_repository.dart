import 'package:excerise_01/data/models/alarm_model.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';

import '../entities/alarm_repeat_type.dart';

abstract class AlarmRepository {
  Future<AlarmEntity?> createAlarm(AlarmModel model);

  Future<List<AlarmEntity>> getAlarms();

  Future<AlarmEntity?> getAlarmById(int id);

  Future<void> deleteAlarmById(int id);

  Future<void> deleteAllAlarms(List<int> ids);

  Future<AlarmEntity?> updateAlarmStatus(int id, bool isActive);

  Future<AlarmEntity?> updateAlarm(int id, DateTime dateTime, bool isActive);

  Future<AlarmEntity?> updateDetailAlarm(
    int id, {
    required DateTime dateTime,
    String? message,
    AlarmRepeatType? repeatType,
    List<int>? days,
  });
}
