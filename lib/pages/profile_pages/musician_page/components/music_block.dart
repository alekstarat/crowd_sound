import 'package:crowd_sound/components/audio_tile.dart';
import 'package:flutter/material.dart';

class MusicBlock extends StatelessWidget {
  final List<dynamic> audios;

  const MusicBlock({super.key, required this.audios});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(255),
              blurRadius: 5,
              //offset: const Offset(0, 2)
            )
          ]),
      child: Column(
        children: List.generate(audios.length, (int index) => AudioTile(id: audios[index])),
      )
    );
  }
}
