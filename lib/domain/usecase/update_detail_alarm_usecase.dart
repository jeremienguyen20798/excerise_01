import 'package:excerise_01/di.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/domain/entities/alarm_repeat_type.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';

class UpdateDetailAlarmUseCase {
  final repository = getIt.get<AlarmRepository>();

  Future<AlarmEntity?> execute(
    int id, {
    required DateTime dateTime,
    String? message,
    AlarmRepeatType? repeatType,
    List<int>? days,
  }) async {
    final entity = await repository.updateDetailAlarm(
      id,
      dateTime: dateTime,
      message: message,
      repeatType: repeatType,
    );
    return entity;
  }
}
