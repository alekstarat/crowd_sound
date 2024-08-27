import 'dart:ui';

import 'package:crowd_sound/pages/welcome_page/components/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  late final VideoPlayerController controller;
  double textOpacity = 0, backgroundOpacity = 1;

  void animationStates() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        textOpacity = 1;
      });
    });
    Future.delayed(const Duration(milliseconds: 1800), () {
      setState(() {
        backgroundOpacity = 0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/videos/trap.mp4')
      ..initialize()
      ..setVolume(0)
      ..setLooping(true)
      .then((v) {
        setState(() {});
        controller.play();
      });
    animationStates();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (controller.value.isInitialized) AspectRatio(
            aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                child: VideoPlayer(controller),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15
            ),
            child: Container(),
          ),
          const CustomStepper(),
          AnimatedOpacity(
            opacity: backgroundOpacity, 
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Colors.black,
              child: Center(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1500),
                  opacity: textOpacity,
                  child: const Text(
                    "Привет",
                    style:  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      fontFamily: 'PoiretOne'
                    )
                  ),
                ),
              ),
            )
          )
        ],
      )
    );
  }
}