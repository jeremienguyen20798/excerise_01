import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/domain/entities/alarm_repeat_type.dart';
import 'package:excerise_01/features/alarm/view/alarm_page.dart';
import 'package:excerise_01/features/home/view/home_page.dart';
import 'package:excerise_01/features/repeat/repeat_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouters = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: '/alarm',
          builder: (context, state) {
            final alarm = state.extra as AlarmEntity;
            return AlarmPage(alarm: alarm);
          },
          routes: [
            GoRoute(
              path: '/repeat',
              builder: (context, state) {
                final alarmRepeatType = state.extra as AlarmRepeatType?;
                return RepeatPage(alarmRepeatType: alarmRepeatType);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
