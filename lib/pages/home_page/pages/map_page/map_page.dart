import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(51.509364, -0.12892),
        initialZoom: 9.2
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=b82219592e7f48a9a0a219782320d3cc',
          userAgentPackageName: 'com.example.app',
        ),
        
      ],
    );
  }
}