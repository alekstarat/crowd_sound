import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class MenuBtn extends StatefulWidget {
  
  MenuBtn({super.key, required this.press, required this.riveOnInit, required this.opacity});

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  double opacity;

  @override
  State<MenuBtn> createState() => _MenuBtnState();
}

class _MenuBtnState extends State<MenuBtn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: widget.press,
        child: AnimatedOpacity(
          opacity: widget.opacity,
          duration: const Duration(milliseconds: 200),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: RiveAnimation.asset(
              "assets/riveAssets/menu_button.riv",
              onInit: widget.riveOnInit,
            ),
          ),
        ),
      ),
    );
  }
}