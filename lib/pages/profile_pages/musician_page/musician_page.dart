import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowd_sound/components/actions_button.dart';
import 'package:crowd_sound/components/loading_animation.dart';
import 'package:crowd_sound/models/group_model.dart';
import 'package:crowd_sound/pages/profile_pages/musician_page/components/photo_name_widget.dart';
import 'package:crowd_sound/pages/profile_pages/musician_page/tabs/events_profile_tab.dart';
import 'package:crowd_sound/pages/profile_pages/musician_page/tabs/music_profile_tab.dart';
import 'package:crowd_sound/palettes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class MusicianPage extends StatefulWidget {

  final int id;

  const MusicianPage({super.key, required this.id});

  @override
  State<MusicianPage> createState() => _MusicianPageState();
}

class _MusicianPageState extends State<MusicianPage> with TickerProviderStateMixin {

  final CarouselController controller = CarouselController();
  //GroupModel group = GroupModel.empty;
  late GroupModel group;
  bool isLoaded = false;
  final Dio dio = Dio();
  late final TabController tabController;

  void getHTTP(int id) async {
    setState(() {
      isLoaded = false;
    });
      await dio.get('${HOST_URL}group/$id').then((v) {
        setState(() {
          group = GroupModel.fromJson(v.data);
          isLoaded = true;
        });
      });
    
    
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getHTTP(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            if (isLoaded) Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
              child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.7,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        MusicProfileTab(audios: group.audios,),
                        EventsProfileTab(events: group.events,)
                      ]
                    ),
                  ),
            ),
            if (isLoaded) SingleChildScrollView(
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.8),
                      offset: const Offset(0, 15),
                      blurRadius: 10,
                    )
                  ]
                ),
                child: PhotoNameWidget(
                  name: group.name, 
                  images: group.images, 
                  carouselController: controller,
                  tabController: tabController
                ),
                ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1)
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white.withOpacity(0.5),
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ActionsButton(),
                ),
              )
            ),
            IgnorePointer(
              ignoring: isLoaded,
              child: LoadingAnimation(colors: purplePalette, opacity: isLoaded ? 0 : 1,)
            )
          ],
        ),
      )
    );
  }
}