import 'dart:ui';
import 'package:flutter/material.dart';

class CategorySelectorTile extends StatelessWidget {

  final String name, image;

  const CategorySelectorTile({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Image.asset(image, height: double.infinity, fit: BoxFit.cover,),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent]
              )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      fontFamily: "PoiretOne"
                    )
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}