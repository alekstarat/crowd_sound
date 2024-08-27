import 'package:crowd_sound/pages/home_page/pages/main_tab/pages/concert_page/concert_page.dart';
import 'package:crowd_sound/pages/home_page/pages/main_tab/pages/music_page/music_page.dart';
import 'package:crowd_sound/pages/home_page/pages/main_tab/pages/studios_page/studios_page.dart';
import 'package:flutter/material.dart';

class MainTab extends StatefulWidget {

  final TabController tabController;

  const MainTab({super.key, required this.tabController});

  void selectCategory(int index) {
    tabController.animateTo(index);
  }

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {

    final List<Widget> tabs = [
      const RotatedBox(
        quarterTurns: -1,
        child: SizedBox(
          child: Center(
            child: MusicPage()
          ),
        ),
      ),
      const RotatedBox(
        quarterTurns: -1,
        child: SizedBox(
          child: Center(
            child: StudiosPage(),
          ),
        ),
      ),
      const RotatedBox(
        quarterTurns: -1,
        child: SizedBox(
          child: ConcertPage()
        ),
      ),
    ];
    return SizedBox(
      child: RotatedBox(
        quarterTurns: 1,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: widget.tabController,
          children: tabs
        ),
      )
    );
  }
}