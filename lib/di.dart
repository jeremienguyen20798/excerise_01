import 'package:excerise_01/data/repositories/alarm_repository_impl.dart';
import 'package:excerise_01/domain/repository/alarm_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/notification/alarm_notification.dart';
import 'data/local_db/alarm_local_db.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> setUp() async {
    await AlarmNotification().notificationInitial();
    tz.initializeTimeZones();
    await AlarmLocalDB().initDatabase();
    AlarmRepository alarmRepository = AlarmRepositoryImpl();
    getIt.registerSingleton<AlarmRepository>(alarmRepository);
  }
}
