import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialSettingsState extends SettingsState {}

class LoadAppVersionState extends SettingsState {
  final String appVersion;
  final String buildNumber;

  LoadAppVersionState(this.appVersion, this.buildNumber);

  @override
  List<Object?> get props => [appVersion, buildNumber];
}
