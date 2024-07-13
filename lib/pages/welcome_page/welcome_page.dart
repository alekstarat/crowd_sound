import 'dart:math';

import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 54, 118, 1),
      body: Stack(
        children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromRGBO(39, 39, 101, 1)],
              transform: GradientRotation(2*pi)
            )
          ),
        ),

        Image.asset(
          "assets/images/welcome.jpg",
          
        )
      ],
      ),
    );
  }
}