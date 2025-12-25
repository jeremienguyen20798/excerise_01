import 'dart:developer';

import 'package:isar_community/isar.dart';
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

  Future<AlarmModel?> writeAlarm(AlarmModel alarm) async {
    final isar = await localDb;
    final result = isar.writeTxnSync(() {
      Id? id = isar.alarmModels.putSync(alarm);
      log('Create alarm successfully with: $id');
      return isar.alarmModels.getSync(id);
    });
    return result;
  }

  Future<AlarmModel?> updateAlarmStatus(int idAlarm, bool? status) async {
    final isar = await localDb;
    AlarmModel? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm.isActive = status;
      final result = isar.writeTxnSync(() {
        Id? id = isar.alarmModels.putSync(alarm);
        return isar.alarmModels.getSync(id);
      });
      return result;
    }
    return null;
  }

  Future<AlarmModel?> updateAlarm(
    int idAlarm,
    DateTime dateTime,
    bool? status,
  ) async {
    final isar = await localDb;
    AlarmModel? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm
        ..time = dateTime
        ..isActive = status;
      final result = isar.writeTxnSync(() {
        int id = isar.alarmModels.putSync(alarm);
        log('Update alarm successfully');
        return isar.alarmModels.getSync(id);
      });
      return result;
    }
    return null;
  }

  Future<AlarmModel?> updateDetailAlarm({
    required int idAlarm,
    DateTime? dateTime,
    String? message,
    AlarmRepeatType? repeatType,
    bool? isDeletedAlarmAfterRing,
  }) async {
    final isar = await localDb;
    AlarmModel? alarm = await getAlarmById(idAlarm);
    if (alarm != null) {
      alarm
        ..time = dateTime ?? DateTime.now()
        ..message = message
        ..repeatType = repeatType ?? AlarmRepeatType.onlyOnce
        ..isDeletedAfterRing = isDeletedAlarmAfterRing;
      final result = isar.writeTxnSync(() {
        int id = isar.alarmModels.putSync(alarm);
        log('Update alarm successfully');
        return isar.alarmModels.getSync(id);
      });
      return result;
    }
    return null;
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
