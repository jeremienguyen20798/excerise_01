import 'package:excerise_01/core/extensions/day_alarm_ext.dart';
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
      if (inMinutes <= 0) {
        return 'Báo thức sắp đến...';
      }
      return 'Báo thức sau $inMinutes phút';
    }
  }

  static String formatTimeStr(DateTime dateTime) {
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  static String formatDaysToStr(List<int> days) {
    String dayListStr = ' ';
    for (int day in days) {
      dayListStr += day.getStr();
    }
    return dayListStr;
  }

  static String formatDuration(Duration duration) {
    // Lấy tổng số phút từ Duration.
    // Dart's Duration có thuộc tính inMinutes, nhưng chúng ta cần tổng số phút
    // bao gồm cả số phút tròn và phần phút lẻ được tính vào giây.
    int totalMinutes = duration.inMinutes;
    // Lấy số giây còn lại sau khi đã tính các phút.
    // totalMinutes * 60 là tổng số giây đã nằm trong số phút tròn.
    // duration.inSeconds - (totalMinutes * 60) là số giây còn lại (0 đến 59).
    int remainingSeconds = duration.inSeconds.remainder(60);
    // Định dạng phút (mm) với số 0 đứng đầu nếu cần.
    // totalMinutes.toString().padLeft(2, '0') đảm bảo luôn có 2 chữ số.
    String minutes = totalMinutes.toString().padLeft(2, '0');
    // Định dạng giây (ss) với số 0 đứng đầu.
    String seconds = remainingSeconds.toString().padLeft(2, '0');
    // Trả về chuỗi kết quả: mm:ss
    return '$minutes:$seconds';
  }
}
