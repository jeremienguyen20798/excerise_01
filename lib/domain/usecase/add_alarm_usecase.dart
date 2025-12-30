import 'package:excerise_01/data/models/alarm_model.dart';
import 'package:excerise_01/di.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/domain/entities/alarm_repeat_type.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';

class AddAlarmUseCase {
  final repository = getIt.get<AlarmRepository>();

  Future<AlarmEntity?> execute(
    DateTime dateTime,
    String message,
    AlarmRepeatType repeatType,
    List<int>? dayList,
    bool isDeletedAlarmAfterRing
  ) async {
    final model = AlarmModel(
      time: dateTime,
      message: message,
      repeatType: repeatType,
      days: dayList,
      isDeletedAfterRing: isDeletedAlarmAfterRing
    );
    final result = await repository.createAlarm(model);
    return result;
  }
}
