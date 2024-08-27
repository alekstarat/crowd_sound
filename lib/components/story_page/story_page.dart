import 'package:flutter/material.dart';
import 'package:story/story.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
          itemBuilder: (context, pageIndex, storyIndex) {
            return Container(
              color: Colors.black,
            );
          },
          storyLength: (int pageIndex) {
            return 2;
          },
          pageLength: 1,
          onPageLimitReached: () {
            Navigator.pop(context);
          },
        ),
    );
  }
}
