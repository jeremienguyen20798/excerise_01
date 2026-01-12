import 'package:excerise_01/core/utils/formatter.dart';
import 'package:excerise_01/widgets/compoment/ringtone_audio_seekbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

class PlayRingtoneDialog extends StatefulWidget {
  final String nameRingtone;
  final String ringtoneUrl;

  const PlayRingtoneDialog({
    super.key,
    required this.nameRingtone,
    required this.ringtoneUrl,
  });

  @override
  State<PlayRingtoneDialog> createState() => _PlayRingtoneDialogState();
}

class _PlayRingtoneDialogState extends State<PlayRingtoneDialog> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration totalDuration = Duration.zero, currentDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.0),
      ),
      titlePadding: EdgeInsets.symmetric(horizontal: 12.0),
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          widget.nameRingtone,
          maxLines: 1,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.close),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RingtoneAudioSeekbar(
            player: audioPlayer,
            onSeekBarChanged: (Duration duration) {
              setState(() {
                currentDuration = duration;
              });
            },
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        RichText(
          text: TextSpan(
            text: Formatter.formatDuration(currentDuration),
            style: TextStyle(color: Colors.black, fontSize: 14.0),
            children: [
              TextSpan(text: ' / '),
              TextSpan(text: Formatter.formatDuration(totalDuration)),
            ],
          ),
        ),
        MaterialButton(
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () {
            setState(() {
              isPlaying = audioPlayer.playing;
              if (isPlaying) {
                pauseRingtone();
              } else {
                playRingtone();
              }
            });
          },
          child: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        ),
      ],
    );
  }

  Future<void> initAudioPlayer() async {
    try {
      totalDuration =
          await audioPlayer.setUrl(widget.ringtoneUrl) ?? Duration.zero;
      isPlaying = audioPlayer.playing;
      currentDuration = audioPlayer.position;
      setState(() {});
    } catch (error) {
      onLoadRingtoneError();
    }
  }

  void onLoadRingtoneError() {
    EasyLoading.showError("Không tải được nhạc chuông này");
    context.pop();
  }

  Future<void> pauseRingtone() async {
    audioPlayer.pause();
  }

  Future<void> playRingtone() async {
    audioPlayer.play();
  }
}
