import 'package:excerise_01/di.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';

class GetAlarmsUseCase {
  final _repository = getIt.get<AlarmRepository>();

  Future<List<AlarmEntity>> execute() {
    return _repository.getAlarms();
  }
}
