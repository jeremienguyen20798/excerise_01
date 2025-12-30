import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

// Lớp này giữ các luồng (streams) cần thiết để xây dựng UI
class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class RingtoneAudioSeekbar extends StatelessWidget {
  final AudioPlayer player;
  final Function(Duration) onSeekBarChanged;

  const RingtoneAudioSeekbar({
    super.key,
    required this.player,
    required this.onSeekBarChanged,
  });

  // 1. Kết hợp các Streams thành một PositionData duy nhất
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero, // Nếu duration là null, dùng Duration.zero
        ),
      ).onErrorReturn(
        const PositionData(Duration.zero, Duration.zero, Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: _positionDataStream, // Lắng nghe stream kết hợp
      builder: (context, snapshot) {
        final positionData =
            snapshot.data ??
            PositionData(Duration.zero, Duration.zero, Duration.zero);
        final duration = positionData.duration;
        final position = positionData.position;
        final bufferedPosition = positionData.bufferedPosition;
        // Tính giá trị của Slider. value phải là double
        final sliderValue = duration.inMilliseconds == 0
            ? 0.0
            : position.inMilliseconds.toDouble();
        // Tính giá trị Secondary cho phần đã đệm (buffered)
        final secondaryValue = duration.inMilliseconds == 0
            ? 0.0
            : bufferedPosition.inMilliseconds.toDouble();
        final maxDuration = duration.inMilliseconds.toDouble();
        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            // Loại bỏ hình tròn khi kéo để nó trông giống thanh tiến trình hơn
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
            trackHeight: 1.0,
            padding: EdgeInsets.zero,
          ),
          child: Slider(
            min: 0.0,
            padding: EdgeInsets.zero,
            max: maxDuration, // Max value là tổng độ dài
            value: sliderValue.clamp(
              0.0,
              maxDuration,
            ), // Đảm bảo value nằm trong khoảng [min, max]
            // Giá trị Secondary cho phần đã đệm/tải (màu nhạt hơn)
            secondaryTrackValue: secondaryValue.clamp(0.0, maxDuration),
            onChanged: (double value) {
              // Xử lý khi người dùng kéo Slider
              onSeekBarChanged(Duration(milliseconds: value.round()));
            },
            onChangeEnd: (double value) {
              // Xử lý khi người dùng thả Slider, tìm kiếm vị trí mới
              player.seek(Duration(milliseconds: value.round()));
            },
          ),
        );
      },
    );
  }
}
