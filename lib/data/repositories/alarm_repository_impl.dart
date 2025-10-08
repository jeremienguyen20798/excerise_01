import 'package:excerise_01/data/local_db/alarm_local_db.dart';
import 'package:excerise_01/data/models/alarm_model.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';

class AlarmRepositoryImpl extends AlarmRepository {
  final AlarmLocalDB _localDB = AlarmLocalDB();

  @override
  Future<void> createAlarm(AlarmModel model) async {
    await _localDB.writeAlarm(model);
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
  Future<void> updateAlarmStatus(int id, bool isActive) async {
    await _localDB.updateAlarmStatus(id, isActive);
  }

  @override
  Future<void> updateAlarm(int id, DateTime dateTime, bool isActive) async {
    await _localDB.updateAlarm(id, dateTime, isActive);
  }
}
