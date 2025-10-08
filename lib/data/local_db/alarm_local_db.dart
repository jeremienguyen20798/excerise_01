import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/alarm_repeat_type.dart';
import '../models/alarm_model.dart';

class AlarmLocalDB {
  late Future<Isar> localDb;

  AlarmLocalDB() {
    localDb = initDatabase();
  }

  Future<Isar> initDatabase() async {
    final documentDir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [AlarmModelSchema],
        directory: documentDir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> writeAlarm(AlarmModel alarm) async {
    final isar = await localDb;
    isar.writeTxnSync(() {
      Id? id = isar.alarmModels.putSync(alarm);
      log('Create alarm successfully with: $id');
    });
  }

  Future<void> updateAlarmStatus(int idAlarm, bool? status) async {
    final isar = await localDb;
    AlarmModel? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm.isActive = status;
      isar.writeTxnSync(() {
        Id? id = isar.alarmModels.putSync(alarm);
        log('Update alarm status successfully with Id: $id - status: $status');
      });
    }
  }

  Future<void> updateAlarm(int idAlarm, DateTime dateTime, bool? status) async {
    final isar = await localDb;
    AlarmModel? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm
        ..time = dateTime
        ..isActive = status;
      isar.writeTxnSync(() {
        isar.alarmModels.putSync(alarm);
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
    AlarmModel? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm
        ..time = dateTime ?? DateTime.now()
        ..message = message
        ..repeatType = repeatType ?? AlarmRepeatType.onlyOnce;
      isar.writeTxnSync(() {
        isar.alarmModels.putSync(alarm);
        log('Update alarm successfully');
      });
    }
  }

  Future<AlarmModel?> getAlarmById(int id) async {
    final isar = await localDb;
    return isar.alarmModels.getSync(id);
  }

  Future<List<AlarmModel>> getAlarms() async {
    final isar = await localDb;
    List<AlarmModel>? alarms = await isar.alarmModels.where().findAll();
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
        isar.alarmModels.deleteSync(existingAlarm.id);
      }
    });
  }

  Future<void> deleteAlarms(List<int> alarmIds) async {
    final isar = await localDb;
    isar.writeTxnSync(() {
      isar.alarmModels.deleteAllSync(alarmIds);
    });
  }
}
