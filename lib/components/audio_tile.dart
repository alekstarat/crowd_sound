import 'package:crowd_sound/components/audioplayer/audioplayer.dart';
import 'package:crowd_sound/components/like_toggle.dart';
import 'package:crowd_sound/palettes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AudioTile extends StatefulWidget {

  final int id;

  const AudioTile({super.key, required this.id});

  @override
  State<AudioTile> createState() => _AudioTileState();
}

class _AudioTileState extends State<AudioTile> {

  final Dio dio = Dio();
  bool isLoading = true;
  late final String name, artist, file, image;

  void getHTTP() async {
    setState(() {
      isLoading = true;
    });
    try {
      await dio.get('${HOST_URL}audio/${widget.id}').then((v) {
        setState(() {
          name = v.data['name'];
          artist = v.data['artist'];
          file = v.data['path'];
          image = v.data['image'];
          isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          opaque: false, 
          barrierDismissible: true, 
          fullscreenDialog: true, 
          barrierColor: Colors.black.withOpacity(0.8),  
          pageBuilder: (context, _, __) => Audioplayer(name: file, image: image, id: widget.id,)
        )
      );
      },
      child: ListTile(
        title: Text(
          isLoading? "" : name,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.bold,
            fontFamily: "PoiretOne"
          )
        ),
        subtitle: Text(
          isLoading? "" : artist,
          style: TextStyle(
            color: Colors.white.withOpacity(0.2),
            fontWeight: FontWeight.bold,
            fontFamily: "PoiretOne"
          )
        ),
        trailing: LikeToggle(isLiked: false, size: 20),
        leading: Hero(
          tag: "${widget.id}",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: isLoading? const SizedBox(width: 0, height: 0,) : Image.network("${HOST_URL}image/$image"),
          ),
        ),
      ),
    );
  }
}