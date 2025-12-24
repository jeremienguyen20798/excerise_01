import 'package:flutter/material.dart';

abstract class SettingsEvent {}

class LoadAppVersionEvent extends SettingsEvent {}

class SelectedLanguageEvent extends SettingsEvent {
  final Locale locale;

  SelectedLanguageEvent(this.locale);
}