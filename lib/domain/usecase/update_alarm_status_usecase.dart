import 'package:excerise_01/di.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';

class UpdateAlarmStatusUseCase {
  final repository = getIt.get<AlarmRepository>();

  Future<AlarmEntity?> execute(int id, bool isActive) async {
    final result = await repository.updateAlarmStatus(id, isActive);
    return result;
  }
}
