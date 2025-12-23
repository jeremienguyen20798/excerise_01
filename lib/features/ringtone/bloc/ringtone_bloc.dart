import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_event.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_state.dart';
import 'package:excerise_01/domain/entities/ringtone_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class RingtoneBloc extends Bloc<RingtoneEvent, RingtoneState> {
  RingtoneBloc() : super(RingtoneInitial()) {
    on<LoadingRingtoneListEvent>(_loadRingtones);
  }

  Future<void> _loadRingtones(
    LoadingRingtoneListEvent event,
    Emitter<RingtoneState> emitter,
  ) async {
    try {
      // Gọi HTTP GET đến `baseUrl` (được định nghĩa trong `app_constant.dart`).
      // Nếu bạn muốn crawl một URL cụ thể khác, có thể thay `baseUrl` bằng chuỗi.
      final response = await http.get(Uri.parse(baseUrl));
      // Kiểm tra mã trả về. Nếu không phải 200 (OK), ta phát lại state ban đầu
      // hoặc có thể phát một state lỗi riêng để UI hiển thị.
      if (response.statusCode != 200) {
        emitter(RingtoneInitial());
        return;
      }
      // Parse thân HTML thành DOM để có thể query các selector giống như trong
      // trình duyệt (querySelectorAll, text, attributes, ...)
      final document = html_parser.parse(response.body);
      // Danh sách tạm để theo dõi các href đã thu thập (dùng để loại trùng).
      final anchors = <String>{};
      // Danh sách kết quả sẽ chứa `RingtoneEntity`.
      final ringtones = <RingtoneEntity>[];
      // Cách parsing chính xác cho cấu trúc item đã cung cấp:
      // Mỗi item có dạng:
      // <div class="page-100-item"> ...
      //   <div class="item"><span>1</span><h3><a class="white-space" href="...">...name...</a></h3></div>
      //   <div class="item"><i class="fas fa-headphones"></i>137203</div>
      //   <div class="item">...</div>
      // </div>
      // Vì vậy ta sẽ chọn tất cả `.page-100-item` và trích `h3 a.white-space` và
      // lấy số lượt nghe từ phần tử chứa `.fa-headphones`.
      final items = document.querySelectorAll('.page-100-item');
      for (final item in items) {
        // Tìm anchor chứa tên và đường dẫn
        final a = item.querySelector('h3 a.white-space') ?? item.querySelector('h3 a');
        if (a == null) continue;
        final href = a.attributes['href']?.trim() ?? '';
        final name = a.text.trim();
        if (href.isEmpty || name.isEmpty) continue;
        // Tìm phần tử chứa icon headphones rồi lấy text (số lượt nghe)
        int listens = 0;
        final headphonesEl = item.querySelector('.fa-headphones');
        if (headphonesEl != null) {
          final parent = headphonesEl.parent;
          if (parent != null) {
            final txt = parent.text.trim();
            listens = _extractNumberFromString(txt);
          }
        }
        anchors.add(href);
        ringtones.add(RingtoneEntity(name, href, listens));
      }
      // Phát state chứa danh sách ringtone đã thu thập được.
      emitter(LoadRingtoneListState(ringtones));
    } catch (e) {
      // Bắt lỗi chung: có thể do HTTP, parse hoặc lỗi khác.
      // Ở đây tạm thời phát lại state ban đầu. Bạn có thể thêm một
      // `RingtoneErrorState` để truyền thông tin lỗi chi tiết cho UI.
      emitter(RingtoneInitial());
    }
  }

  // Hàm tiện ích: tách số nguyên từ chuỗi (ví dụ "137203" hoặc "1,372,03").
  // Trả về 0 nếu không tìm thấy số hợp lệ.
  int _extractNumberFromString(String text) {
    if (text.isEmpty) return 0;
    return int.tryParse(text) ?? 0;
  }
}
// Gợi ý nâng cao (không nằm trong code thực thi):
// - Thêm state `RingtoneLoading` và `RingtoneError` để UI có thể hiển thị
//   loading spinner và thông báo lỗi.
// - Nếu cần link trực tiếp tới file nhạc (mp3), cần truy cập từng `href`
//   chi tiết (crawl trang chi tiết) và tìm thẻ <audio> hoặc link tải.
// - Thêm `pubspec.yaml` dependencies: `http: ^x.x.x` và `html: ^x.x.x`.
