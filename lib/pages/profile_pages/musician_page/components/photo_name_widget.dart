import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowd_sound/palettes.dart';
import 'package:flutter/material.dart';

class PhotoNameWidget extends StatelessWidget {

  final TabController tabController;
  final List<dynamic> images;
  final String name;
  final CarouselController carouselController;

  const PhotoNameWidget({super.key, required this.images, required this.carouselController, required this.name, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.3,
        child: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return Image.network('${HOST_URL}image/${images[index]}');
              },
              carouselController: carouselController,
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1
              )
            ),
            IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    transform: const GradientRotation(3*pi/2),
                    colors: [Colors.transparent.withAlpha(255), Colors.transparent]
                  )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      name, 
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontFamily: 'PoiretOne',
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      )
                    ),
                  ),
                  TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                    unselectedLabelColor: Colors.white.withOpacity(0.2),
                    labelColor: Theme.of(context).secondaryHeaderColor.withAlpha(255),
                    labelStyle: const TextStyle(
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold
                    ),
                    controller: tabController,
                    tabs: const [
                      Tab(
                        text: "МУЗЫКА",
                        height: 30,
                      ),
                      Tab(
                        text: "МЕРОПРИЯТИЯ",
                        height: 30,
                      )
                    ]
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}