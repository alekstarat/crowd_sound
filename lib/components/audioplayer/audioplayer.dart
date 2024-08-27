import 'package:audioplayers/audioplayers.dart';
import 'package:crowd_sound/components/audioplayer/audio_slice_widget/audio_slice_widget.dart';
import 'package:crowd_sound/palettes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Audioplayer extends StatefulWidget {

  final int id;
  final String name, image;

  const Audioplayer({super.key, required this.name, required this.image, required this.id});

  @override
  State<Audioplayer> createState() => _AudioplayerState();
}

class _AudioplayerState extends State<Audioplayer> {

  late AudioPlayer player;
  double sliderOpacity = 0.2;
  bool isEditing = false, isPaused = false;
  double volume = 1;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.release);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await player.setSource(UrlSource('${HOST_URL}audio/raw/${widget.name}'));
        await player.setVolume(1);
        await player.resume();
        
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void setVolume(double v) async {
    await player.setVolume(v);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width*0.8;
    var sliceWidget = AudioSliceWidget(file: widget.name);
    return GestureDetector(
      onTap: () {
        if (!isEditing) {
          setState(() {
            player.stop();
            sliderOpacity = 0;
          });
          Navigator.pop(context);
        } else {
          setState(() {
            isEditing = false;
          });
        }
        
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color:isEditing? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1)
        ),
        child: Stack(
          children: [
            AnimatedPadding(
              duration: const Duration(milliseconds: 150),
              padding: EdgeInsets.only(bottom: isEditing ? MediaQuery.of(context).size.height*0.3 : 0),
              child: Center(
                child: Hero(
                  tag: "${widget.id}",
                  child: GestureDetector(
                    onLongPress: () {
                      player.pause();
                      setState(() {
                        isPaused = true;
                        isEditing = true;
                        size = MediaQuery.of(context).size.width*0.7;
                      });
                    },
                    onTap: () {
                      if (isPaused) {
                        player.resume();
                        setState(() {
                          isPaused = false;
                        });
                      } else {
                        player.pause();
                        setState(() {
                          isPaused = true;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: size/10,
                            
                          )
                        ]
                      ),
                      width: size,
                      height: size,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size/10),
                        child: Stack(
                          children: [
                            Image.network('${HOST_URL}image/${widget.image}'),
                            AnimatedOpacity(
                              opacity: isPaused ? 1 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                child: Center(
                                  child: Icon(
                                    isPaused ? Icons.play_arrow : Icons.pause_outlined,
                                    color: Colors.white.withOpacity(0.3),
                                    size: size/5,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.4),
                child: AnimatedOpacity(
                  opacity: isEditing ? 1 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: sliceWidget
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.4),
                child: Material(
                  type: MaterialType.transparency,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 40,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      opacity: isEditing ? 0 : sliderOpacity,
                      child: IgnorePointer(
                        ignoring: isEditing,
                        child: Slider(
                          activeColor: Colors.white,
                          divisions: 100,
                          min: 0,
                          max: 1,
                          value: volume, 
                          onChangeEnd: (v) {
                            setState(() {
                              sliderOpacity = 0.2;
                            });
                          },
                          onChangeStart: (v) {
                            setState(() {
                              sliderOpacity = 1;
                            });
                          },
                          onChanged: (v) {
                            setState(() {
                              volume = v;
                            });
                            player.setVolume(v);
                          }
                        ),
                      ),
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}