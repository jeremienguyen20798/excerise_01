import 'package:excerise_01/features/settings/bloc/settings_bloc.dart';
import 'package:excerise_01/features/settings/bloc/settings_event.dart';
import 'package:excerise_01/features/settings/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc()..add(LoadAppVersionEvent()),
      child: SettingsView(),
    );
  }
}
