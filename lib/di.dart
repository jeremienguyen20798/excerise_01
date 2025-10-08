import 'package:excerise_01/data/repositories/alarm_repository_impl.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static void setUp() {
    AlarmRepository alarmRepository = AlarmRepositoryImpl();
    getIt.registerSingleton<AlarmRepository>(alarmRepository);
  }
}
