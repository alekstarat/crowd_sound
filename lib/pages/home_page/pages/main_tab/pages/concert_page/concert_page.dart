import 'dart:math';
import 'package:crowd_sound/pages/home_page/pages/main_tab/pages/components/animated_tile.dart';
import 'package:flutter/material.dart';


class ConcertPage extends StatelessWidget {

  const ConcertPage({super.key});

  @override
  Widget build(BuildContext context) {

    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: GridView(
        controller: scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ),
        children: List.generate(10, (int index) {
          return GestureDetector( 
            onTap: () {
              double yPos = (index ~/ 2)*(MediaQuery.of(context).size.width ~/ 2) - scrollController.offset; 
              if (yPos < 0 || yPos > MediaQuery.of(context).size.height/1.5) {
                scrollController.animateTo(205.0*(index ~/ 2), duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.push(context, PageRouteBuilder(opaque: false, barrierDismissible: true, fullscreenDialog: true, barrierColor: Colors.black.withOpacity(0.8),  pageBuilder: (context, _, __) => AnimatedTile(index: index, offset: yPos < 0 ? 0 : MediaQuery.of(context).size.height / 2 - scrollController.offset, tag: index.toString())));
                });
              } else {
                Navigator.push(context, PageRouteBuilder(opaque: false, barrierDismissible: true, fullscreenDialog: true, barrierColor: Colors.black.withOpacity(0.8),  pageBuilder: (context, _, __) => AnimatedTile(index: index, offset: yPos.abs(), tag: index.toString())));
              }
            },
            child: Hero(
              tag: index.toString(),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColorDark)
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset('assets/images/raskraska.jpg', fit: BoxFit.cover),
                    Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black],
                              transform: GradientRotation(pi/2)
                            )
                          ),
                        ),
                    
                  ],
                ),
                
              ),
            )
          );
        }),
      )
    );
  }
}