import 'package:excerise_01/di.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';

class UpdateAlarmUseCase {
  final repository = getIt.get<AlarmRepository>();

  Future<AlarmEntity?> execute(
    int id, {
    required DateTime dateTime,
    required bool isActive,
  }) async {
    final result = await repository.updateAlarm(id, dateTime, isActive);
    return result;
  }
}
