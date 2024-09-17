import 'dart:math';
import 'package:crowd_sound/palettes.dart';
import 'package:database_repository/database_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEventTile extends StatefulWidget {

  final int id;

  const ProfileEventTile({super.key, required this.id});

  @override
  State<ProfileEventTile> createState() => _ProfileEventTileState();
}

class _ProfileEventTileState extends State<ProfileEventTile> {

  bool isOpened = false, isLoaded = false;

  final Dio dio = Dio();
  late dynamic event, place;

  void loadData() {
    context.read<DatabaseRepository>().getEventModelData(widget.id).then((val) {
      setState(() {
        event = val;
        print(event);
        context.read<DatabaseRepository>().getPlaceModelData(event.place).then((val) {
          setState(() {
            place = val;
            isLoaded = true;
            print(place);
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isOpened ? MediaQuery.of(context).size.height*0.25 : MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15
          )
        ],
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(6)
      ),
      child: GestureDetector(
        onTap: () {
          if (!isOpened) {
            setState(() {
              isOpened = !isOpened;
            });
          } else {
            if (kDebugMode) {
              print('Navigator');
            }
          }
          
        },
        child: Stack(
          children: [
            if (isLoaded) ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: event.images.isNotEmpty ? Image.network(
                '${HOST_URL}image/${event.images[0]}', 
                fit: BoxFit.fitWidth, 
                width: MediaQuery.of(context).size.width*0.9,
              ) : Container(
                color: Colors.grey.shade900,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent,Colors.black.withOpacity(0.9)],
                  transform: const GradientRotation(pi/2)
                )
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isOpened ? -0.5 : 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isOpened = !isOpened;
                      });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down, 
                      size: 35, 
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            if (isLoaded) Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedOpacity(
                      opacity: isOpened ? 1 : 0, 
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        event.date,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PoiretOne',
                          fontSize: 10
                        ),
                      ),
                    ),
                    Text(
                      event.name ?? place.name,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PoiretOne',
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}