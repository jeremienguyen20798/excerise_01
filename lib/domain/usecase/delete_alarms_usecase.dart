import 'package:excerise_01/di.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';

class DeleteAlarmsUseCase {
  final _repository = getIt.get<AlarmRepository>();

  Future<void> execute(List<int> ids) {
    return _repository.deleteAllAlarms(ids);
  }
}