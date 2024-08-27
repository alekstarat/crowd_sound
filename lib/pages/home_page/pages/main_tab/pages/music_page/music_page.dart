import 'package:crowd_sound/pages/home_page/pages/main_tab/pages/music_page/components/compilation_tile.dart';
import 'package:crowd_sound/pages/home_page/pages/main_tab/pages/music_page/components/stories_area.dart';
import 'package:crowd_sound/pages/profile_pages/musician_page/musician_page.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
                  children: [
                    const StoriesArea(),
                    const SizedBox(height: 32,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MusicianPage(id: 2)));
                        },
                        child: const CompilationTile(categoryColor: Colors.yellow, name: "РОК", image: "assets/images/raskraska.jpg")
                      ), 
                      const CompilationTile(categoryColor: Colors.white, name: "РЭП", image: "assets/images/raskraska.jpg")
                    ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
  
}