import 'package:crowd_sound/components/story_page/story_page.dart';
import 'package:flutter/material.dart';

class StoryCircle extends StatefulWidget {
  const StoryCircle({super.key});

  @override
  State<StoryCircle> createState() => _StoryCircleState();
}

class _StoryCircleState extends State<StoryCircle> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = true;
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const StoryPage()));
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black.withOpacity(0.5),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: !isChecked ? 1.0 : 0,
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColorLight, width: 2)
              ),
            ),
          )
        ],
      ),
    );
  }
}