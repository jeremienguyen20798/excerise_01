import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

class AlarmStatusNotifier {
  AlarmStatusNotifier._internal();
  static final AlarmStatusNotifier instance = AlarmStatusNotifier._internal();

  // Tên định danh cho Port giao tiếp
  static const String _isolateName = 'ALARM_ISOLATE_PORT';

  // StreamController để gửi sự kiện
  final StreamController<int> _alarmController =
      StreamController<int>.broadcast();
  // Stream để Bloc lắng nghe
  Stream<int> get dismissedAlarmStream => _alarmController.stream;

  // ReceivePort để lắng nghe từ background isolate
  ReceivePort? _receivePort;

  // 1. Hàm khởi tạo lắng nghe (Gọi 1 lần duy nhất ở main hoặc HomeBloc)
  void initialize() {
    // Đăng ký ReceivePort
    _receivePort = ReceivePort();
    IsolateNameServer.removePortNameMapping(_isolateName);
    IsolateNameServer.registerPortWithName(
      _receivePort!.sendPort,
      _isolateName,
    );

    // Lắng nghe dữ liệu gửi về từ background
    _receivePort!.listen((dynamic data) {
      if (data is int) {
        _alarmController.add(data); // Đẩy vào stream cho Bloc nghe
      }
    });
  }

  // Phương thức gọi từ background/notification handler
  void notifyDismissal(int alarmId) {
    // Kiểm tra xem có đang ở Main Isolate không
    // Nếu SendPort tìm thấy tức là ta đang ở Background, cần gửi về Main
    final SendPort? sendPort = IsolateNameServer.lookupPortByName(_isolateName);
    if (sendPort != null) {
      // Đang ở Background Isolate -> Gửi qua đường ống về Main
      sendPort.send(alarmId);
    } else {
      // Đang ở Main Isolate (App đang mở foreground) -> Add trực tiếp
      if (!_alarmController.isClosed) {
        _alarmController.add(alarmId);
      }
    }
  }

  // Phương thức để đóng Stream (nên gọi khi ứng dụng tắt nếu cần)
  void dispose() {
    _receivePort?.close();
    IsolateNameServer.removePortNameMapping(_isolateName);
    _alarmController.close();
  }
}
