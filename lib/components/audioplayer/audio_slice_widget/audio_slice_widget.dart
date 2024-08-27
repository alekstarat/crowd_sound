import 'dart:math';

import 'package:crowd_sound/palettes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AudioSliceWidget extends StatefulWidget {

  final String file;

  const AudioSliceWidget({super.key, required this.file});

  @override
  State<AudioSliceWidget> createState() => _AudioSliceWidgetState();
}

class _AudioSliceWidgetState extends State<AudioSliceWidget> {

  late final dynamic response;
  final Dio dio = Dio();
  bool isLoaded = false;
  double selectedPosition = 1;
  double selectedLength = 100;

  void getHTTP() async {
    setState(() {
      isLoaded = false;
    });
    try {
      await dio.get('${HOST_URL}audio/plot/${widget.file}').then((v) {
        setState(() {
          response = v.data;
          isLoaded = true;
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getHTTP();
  }

  Widget activeArea(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        try {
          setState(() {
            selectedPosition += details.delta.dx;
          });
        } catch (e) {
          print(e.toString());
        }
      },         
      child: Padding(
        padding: EdgeInsets.only(left: selectedPosition >= 0 ? selectedPosition : 0),
        child: AnimatedContainer(
          duration: const Duration(seconds: 0),
          width: selectedLength > 20 ? selectedLength : 20,
          height: 100,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 0),
                width: selectedLength > 20 ? selectedLength : 20,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.withOpacity(0.3), Colors.transparent, Colors.green.withOpacity(0.3)],
                    transform: const GradientRotation(pi/2)
                  ),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 10,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.7)
                    )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    
                    try {
                      setState(() {
                        if (selectedLength < 50) {
                          selectedLength = 50;
                        } else if (selectedLength > 150) {
                          selectedLength = 150;
                        } else {
                          selectedLength += details.delta.dx;
                        }
                      });
                    } catch (e) {
                      if (kDebugMode) {
                        print(e.toString());
                      }
                    }
                  
                  },
                  child: Container(
                    width: 10,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.7)
                      )
                    ),
                    child: Center(
                      child: Container(
                        width: 1,
                        height: 75,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
                colors: [Colors.black, Colors.transparent],
                transform: GradientRotation(pi/2)
              ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (isLoaded) ...List.generate(response['data'].length, (int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    width: 1,
                    height: response['data'][index].toDouble() < 80 ? response['data'][index].toDouble() : 80,
                    
                  );
                })
              ],
            ),
          ),
        ),
        if (isLoaded) activeArea(context)
      ],
    );
  }
}