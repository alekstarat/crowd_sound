import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LikeToggle extends StatefulWidget {

  bool isLiked;
  final double size;

  LikeToggle({super.key, required this.isLiked, required this.size});

  @override
  State<LikeToggle> createState() => _LikeToggleState();
}

class _LikeToggleState extends State<LikeToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isLiked = !widget.isLiked;
        });
      },
      child: Icon(
        widget.isLiked? Icons.favorite_rounded : Icons.favorite_outline,
        size: widget.size,
        color: widget.isLiked? Colors.red : Colors.white.withOpacity(0.2),
      ),
    );
  }
}