import 'package:crowd_sound/feauters/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {

  bool isPanelOpen = false;
  final PanelController _controller = PanelController();

  double? long, lat;
  late MapController mapController;
  
  @override  
  void initState() {
    super.initState();
    mapController = MapController();
    determinePosition().then((value) {
      setState(() {
        long = value.longitude;
        lat = value.latitude;
      });
      mapController.move(LatLng(lat!, long!), 9.0);
    });
  }

  Widget slidingPanel(BuildContext context) {
    return Stack(
      children:[
        Container(), // set the contents behind the panel
        Align(
          alignment: Alignment.bottomCenter,
          child: SlidingUpPanel(
            controller: _controller,
            defaultPanelState: isPanelOpen ? PanelState.OPEN : PanelState.CLOSED,
            header: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 150),
              child: Container(
                height: 3,
                width: MediaQuery.of(context).size.width-300,
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: BorderRadius.circular(90)
                ),
              ),
            ),
            color: Theme.of(context).scaffoldBackgroundColor, //set the panel color
            minHeight: MediaQuery.of(context).size.height / 7, //set min height
            maxHeight: 450, // set desired max height when expanded
            borderRadius: const BorderRadius.only( // border decorations
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            panel: const Column(
              children: [],
             ), // contents of the panel
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onPositionChanged: (_,  __) {
                  _controller.close();
                  setState(() {
                    isPanelOpen = false;
                  });
                },
                onTap: (_, __) {
                  if (isPanelOpen) {
                    _controller.close();
                    setState(() {
                      isPanelOpen = false;
                    });
                  } else {
                    _controller.open();
                  setState(() {
                    isPanelOpen = true;
                  });
                  }
                },
                //onMapReady: () {
                  //show(context);
                //},
                initialCenter: lat == null || long == null ? const LatLng(0, 0) : LatLng(lat!, long!),
                initialZoom: 9.2
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=b82219592e7f48a9a0a219782320d3cc',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
            slidingPanel(context)
        ],
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}