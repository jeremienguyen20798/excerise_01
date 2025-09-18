import 'package:intl/intl.dart';

class Formatter {
  static String formatTime(Duration duration) {
    final inHours = duration.inHours;
    final inMinutes = duration.inMinutes; //Vi du: 3 gio 2 phut -> 192 phut

    if (inHours > 0) {
      if (inMinutes > 0) {
        final minutes = inMinutes % 60;
        return 'Báo thức sau $inHours giờ $minutes phút';
      }
      return 'Báo thức sau $inHours';
    } else {
      return 'Báo thức sau $inMinutes phút';
    }
  }

  static String formatTimeStr(DateTime dateTime) {
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }
}
