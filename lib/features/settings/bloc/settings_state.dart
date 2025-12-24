import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class SelectedLanguageState extends SettingsState {
  final Locale selectedLocaled;

  SelectedLanguageState(this.selectedLocaled);

  @override
  List<Object?> get props => [selectedLocaled];
}
