import 'package:excerise_01/data/models/alarm_model.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';

abstract class AlarmRepository {
  Future<void> createAlarm(AlarmModel model);

  Future<List<AlarmEntity>> getAlarms();

  Future<AlarmEntity?> getAlarmById(int id);

  Future<void> deleteAlarmById(int id);

  Future<void> deleteAllAlarms(List<int> ids);

  Future<void> updateAlarmStatus(int id, bool isActive);

  Future<void> updateAlarm(int id, DateTime dateTime, bool isActive);
}
