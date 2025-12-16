import 'package:excerise_01/data/local_db/alarm_local_db.dart';
import 'package:excerise_01/data/models/alarm_model.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';

import '../../domain/entities/alarm_repeat_type.dart';

class AlarmRepositoryImpl extends AlarmRepository {
  final AlarmLocalDB _localDB = AlarmLocalDB();

  @override
  Future<AlarmEntity?> createAlarm(AlarmModel model) async {
    final alarmModel = await _localDB.writeAlarm(model);
    return alarmModel?.toEntity();
  }

  @override
  Future<AlarmEntity?> getAlarmById(int id) async {
    final alarmModel = await _localDB.getAlarmById(id);
    if (alarmModel != null) {
      return alarmModel.toEntity();
    }
    return null;
  }

  @override
  Future<List<AlarmEntity>> getAlarms() async {
    final alarms = await _localDB.getAlarms();
    return alarms.map((item) => item.toEntity()).toList();
  }

  @override
  Future<void> deleteAlarmById(int id) async {
    await _localDB.deleteAlarmById(id);
  }

  @override
  Future<void> deleteAllAlarms(List<int> ids) async {
    await _localDB.deleteAlarms(ids);
  }

  @override
  Future<AlarmEntity?> updateAlarmStatus(int id, bool isActive) async {
    final alarm = await getAlarmById(id);
    if (alarm != null) {
      final distance = DateTime.now().difference(alarm.time).inDays;
      if (distance == 0) {
        final result = await _localDB.updateAlarmStatus(id, isActive);
        return result?.toEntity();
      } else {
        alarm.time = alarm.time.add(Duration(days: distance));
        final result = await _localDB.updateAlarm(id, alarm.time, isActive);
        return result?.toEntity();
      }
    }
    return null;
  }

  @override
  Future<AlarmEntity?> updateAlarm(
    int id,
    DateTime dateTime,
    bool isActive,
  ) async {
    final result = await _localDB.updateAlarm(id, dateTime, isActive);
    return result?.toEntity();
  }

  @override
  Future<AlarmEntity?> updateDetailAlarm(
    int id, {
    required DateTime dateTime,
    String? message,
    AlarmRepeatType? repeatType,
    List<int>? days,
  }) async {
    final model = await _localDB.updateDetailAlarm(
      idAlarm: id,
      dateTime: dateTime,
      message: message,
      repeatType: repeatType,
    );
    return model?.toEntity();
  }
}
