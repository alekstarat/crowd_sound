import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowd_sound/pages/home_page/components/category_selector/category_selector_tile.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {

  final CarouselController _carouselController = CarouselController();
  final TabController categoryController;

  CategorySelector({super.key, required this.categoryController});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {

  

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      
      carouselController: widget._carouselController,
      items: const [
        CategorySelectorTile(name: "МУЗЫКА", image: 'assets/images/music.jpg'),
        CategorySelectorTile(name: "СТУДИИ", image: 'assets/images/studios.jpg'),
        CategorySelectorTile(name: "КОНЦЕРТЫ", image: 'assets/images/concerts.png'),
      ], 
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          widget.categoryController.animateTo(index);
        },
        viewportFraction: 1,
        height: double.infinity,
        enableInfiniteScroll: false,
        scrollDirection: Axis.vertical
      )
    );
  }
}