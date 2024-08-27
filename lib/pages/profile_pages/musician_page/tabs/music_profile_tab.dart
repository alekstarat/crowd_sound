import 'package:crowd_sound/pages/profile_pages/musician_page/components/music_block.dart';
import 'package:flutter/material.dart';

class MusicProfileTab extends StatefulWidget {

  final List<dynamic> audios;

  const MusicProfileTab({super.key, required this.audios});

  @override
  State<MusicProfileTab> createState() => _MusicProfileTabState();
}

class _MusicProfileTabState extends State<MusicProfileTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MusicBlock(audios: widget.audios,),
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}