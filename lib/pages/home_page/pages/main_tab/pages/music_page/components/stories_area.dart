import 'package:crowd_sound/pages/home_page/pages/main_tab/pages/music_page/components/story_circle.dart';
import 'package:flutter/material.dart';

class StoriesArea extends StatelessWidget {
  const StoriesArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5.0,
            offset: const Offset(0.0, 5.0),
          )
        ],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24))
      ),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return const StoryCircle();
        },
        separatorBuilder: (context, index) => const SizedBox(width: 12,),
      ),
    );
  }
}