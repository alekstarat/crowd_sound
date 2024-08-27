import 'dart:math';
import 'dart:convert';
import 'package:crowd_sound/models/event_model.dart';
import 'package:crowd_sound/models/place_model.dart';
import 'package:crowd_sound/palettes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileEventTile extends StatefulWidget {

  final int id;

  const ProfileEventTile({super.key, required this.id});

  @override
  State<ProfileEventTile> createState() => _ProfileEventTileState();
}

class _ProfileEventTileState extends State<ProfileEventTile> {

  bool isOpened = false;

  final Dio dio = Dio();
  EventModel event = EventModel.empty;
  PlaceModel place = PlaceModel.empty;
  void getHTTP(int id) async {
    try {
      await dio.get("${HOST_URL}event/$id").then((v) {
        setState(() {
          event = event.copyWith(
            name: v.data['name'],
            desc: v.data['desc'],
            date: v.data['date'],
            images: json.decode(v.data['images']),
            place: v.data['place']
          );
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    await dio.get("${HOST_URL}place/${event.place}").then((v) {
        setState(() {
          place = place.copyWith(
            name: v.data['name'],
            social: v.data['social'],
            images: json.decode(v.data['images']) as List<dynamic>,
            events: json.decode(v.data['events']) as List<dynamic>,
            position: json.decode(v.data['position']) as List<dynamic>
          );
        });
      });
  }

  @override
  void initState() {
    super.initState();
    getHTTP(widget.id);
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
            ClipRRect(
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
            Align(
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
                      event.name == "" ? place.name : event.name!,
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