import 'dart:developer';

import 'package:excerise_01/entities/alarm.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/alarm_repeat_type.dart';

class AlarmLocalDB {
  late Future<Isar> localDb;

  AlarmLocalDB() {
    localDb = initDatabase();
  }

  Future<Isar> initDatabase() async {
    final documentDir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [AlarmSchema],
        directory: documentDir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> writeAlarm(Alarm alarm) async {
    final isar = await localDb;
    isar.writeTxnSync(() {
      Id? id = isar.alarms.putSync(alarm);
      log('Create alarm successfully with: $id');
    });
  }

  Future<void> updateAlarmStatus(int idAlarm, bool? status) async {
    final isar = await localDb;
    Alarm? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm.isActive = status;
      isar.writeTxnSync(() {
        Id? id = isar.alarms.putSync(alarm);
        log('Update alarm status successfully with Id: $id - status: $status');
      });
    }
  }

  Future<void> updateAlarm(int idAlarm, DateTime dateTime, bool? status) async {
    final isar = await localDb;
    Alarm? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm
        ..time = dateTime
        ..isActive = status;
      isar.writeTxnSync(() {
        isar.alarms.putSync(alarm);
        log('Update alarm successfully');
      });
    }
  }

  Future<void> updateDetailAlarm({
    required int idAlarm,
    DateTime? dateTime,
    String? message,
    AlarmRepeatType? repeatType,
  }) async {
    final isar = await localDb;
    Alarm? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm
        ..time = dateTime ?? DateTime.now()
        ..message = message
        ..repeatType = repeatType ?? AlarmRepeatType.onlyOnce;
      isar.writeTxnSync(() {
        isar.alarms.putSync(alarm);
        log('Update alarm successfully');
      });
    }
  }

  Future<Alarm?> getAlarmById(int id) async {
    final isar = await localDb;
    return isar.alarms.getSync(id);
  }

  Future<List<Alarm>> getAlarms() async {
    final isar = await localDb;
    List<Alarm>? alarms = await isar.alarms.where().findAll();
    if (alarms.isNotEmpty) {
      return alarms;
    }
    return [];
  }

  Future<void> deleteAlarmById(int alarmId) async {
    final isar = await localDb;
    final existingAlarm = await getAlarmById(alarmId);
    isar.writeTxnSync(() {
      if (existingAlarm != null) {
        isar.alarms.deleteSync(existingAlarm.id);
      }
    });
  }

  Future<void> deleteAlarms(List<int> alarmIds) async {
    final isar = await localDb;
    isar.writeTxnSync(() {
      isar.alarms.deleteAllSync(alarmIds);
    });
  }
}
