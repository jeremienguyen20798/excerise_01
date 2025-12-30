abstract class RingtoneEvent {}

class LoadingRingtoneListEvent extends RingtoneEvent {}

class PlayRingtoneEvent extends RingtoneEvent {
  final String name;
  final String url;

  PlayRingtoneEvent(this.name, this.url);
}
