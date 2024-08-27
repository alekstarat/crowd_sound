import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedTile extends StatelessWidget {


  final String tag;
  final double offset;
  final int index;

  const AnimatedTile({super.key, required this.tag, required this.offset, required this.index});

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: index % 2 == 0 ? Alignment.topLeft : Alignment.topRight,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: offset),
              child: Hero(
                tag: tag,
                child: Material(
                  type: MaterialType.transparency,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColorDark.withOpacity(0.5),
                          blurRadius: 10.0,
                          offset: const Offset(5.0, 4.0)
                        )
                      ],
                      border: Border.all(color: Theme.of(context).primaryColorDark),
                      borderRadius: index % 2 == 0 ? const BorderRadius.only(
                        topRight: Radius.circular(12), 
                        bottomRight: Radius.circular(12),
                      ) : const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: index % 2 == 0 ? const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ) : const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset('assets/images/raskraska.jpg', fit: BoxFit.cover,),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                transform: GradientRotation(pi/2)
                              )
                            ),
                          ),
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8, bottom: 4, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "RASKRASkA",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "PoiretOne",
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.transparent
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 20,)
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
  }
}