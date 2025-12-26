import 'package:excerise_01/domain/entities/ringtone_entity.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_bloc.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_event.dart';
import 'package:excerise_01/features/ringtone/bloc/ringtone_state.dart';
import 'package:excerise_01/widgets/items/item_ringtone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RingtoneEntity> ringtones = [];

class AlarmRingtoneList extends StatelessWidget {
  const AlarmRingtoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RingtoneBloc, RingtoneState>(
      builder: (context, state) {
        if (state is LoadRingtoneListState) {
          ringtones = state.ringtones;
        }
        return ListView.builder(
          itemCount: ringtones.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => ItemRingtone(
            entity: ringtones[index],
            onClicked: (String ringtoneUrl) {
              BlocProvider.of<RingtoneBloc>(
                context,
              ).add(PlayRingtoneEvent(ringtones[index].name, ringtoneUrl));
            },
          ),
        );
      },
    );
  }
}
