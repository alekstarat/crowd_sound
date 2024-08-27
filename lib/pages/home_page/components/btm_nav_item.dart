import 'package:crowd_sound/models/menu.dart';
import 'package:crowd_sound/pages/home_page/components/animated_bar.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BtmNavItems extends StatelessWidget {

  final Menu navBar, selectedNav;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  const BtmNavItems({super.key, required this.navBar, required this.selectedNav, required this.press, required this.riveOnInit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          SizedBox(
            height: 36,
            width: 36,
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: RiveAnimation.asset(
                navBar.rive.src,
                artboard: navBar.rive.artboard,
                onInit: riveOnInit,
              )
            )
          )
        ]
      ),
    );
  }
}