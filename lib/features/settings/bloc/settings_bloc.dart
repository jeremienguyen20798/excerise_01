import 'package:excerise_01/features/settings/bloc/settings_event.dart';
import 'package:excerise_01/features/settings/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(InitialSettingsState()) {
    on<LoadAppVersionEvent>(_loadAppVersion);
    on<SelectedLanguageEvent>(_selectedLanguageFromLocale);
  }

  Future<void> _loadAppVersion(
    LoadAppVersionEvent event,
    Emitter<SettingsState> emitter,
  ) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    emitter(LoadAppVersionState(version, buildNumber));
  }

  void _selectedLanguageFromLocale(
    SelectedLanguageEvent event,
    Emitter<SettingsState> emitter,
  ) {
    final locale = event.locale;
    emitter(SelectedLanguageState(locale));
  }
}
