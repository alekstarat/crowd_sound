import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowd_sound/components/loading_animation.dart';
import 'package:crowd_sound/feauters/auth/components/custom_textfield.dart';
import 'package:crowd_sound/feauters/utils/locator.dart';
import 'package:crowd_sound/palettes.dart';
import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {

  bool isPanelOpen = false, isLoading = true;
  final PanelController _controller = PanelController();
  List<dynamic> places = [];
  double panelOpacity = 0;

  double? long, lat;
  late MapController mapController;
  
  void getPlaces() async {
    places = await context.read<DatabaseRepository>().getPlacesList();
    setState(() {});
  }

  @override  
  void initState() {
    super.initState();
    mapController = MapController();
    getPlaces();
    determinePosition().then((value) {
      setState(() {
        long = value.longitude;
        lat = value.latitude;
      });
      mapController.move(LatLng(lat!, long!), 9.0);
    });
  }

  Widget placeDataSheet(BuildContext context, dynamic place) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12))
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 15,
                  spreadRadius: 10,
                  offset: const Offset(0, 15)
                )
              ]
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CarouselSlider.builder(
                    itemCount: place.images.length, 
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                      return Stack(
                        children: [
                          Image(
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                            image: NetworkImage("http://10.0.2.2:8000/image/${place.images[itemIndex]}")
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                transform: GradientRotation(pi/2)
                              )
                            ),
                          ),
                          
                        ],
                      );
                    }, 
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      height: MediaQuery.of(context).size.height*0.3
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                        place.name,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 25,
                          fontFamily: "PoiretOne"
                        ),
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget slidingPanel(BuildContext context) {
    return Stack(
      children:[
        Container(), // set the contents behind the panel
        Align(
          alignment: Alignment.bottomCenter,
          child: SlidingUpPanel(
            // onPanelClosed: () {
              
            // },
            onPanelSlide: (double opacity) {
              FocusScope.of(context).unfocus();
              setState(() {
                panelOpacity = opacity;
              });
            },
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
            color: Theme.of(context).scaffoldBackgroundColor,
            minHeight: MediaQuery.of(context).size.height / 7,
            maxHeight: 450,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            panel: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: panelOpacity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextfield(controller: TextEditingController(), title: "Поиск", obscure: false, icon: const Icon(Icons.search_outlined), width: double.infinity,),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 16, top: 32),
                        itemCount: places.length,
                        itemBuilder: (BuildContext context, int index) {

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: GestureDetector(
                              onTap: () {
                                mapController.move(LatLng(places[index].position[0], places[index].position[1]), 15);
                                _controller.close();
                              },
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                                  child: ShaderMask(
                                    shaderCallback: (rect) {
                                            return LinearGradient(
                                              colors: [Colors.black, Colors.black.withOpacity(0.9), Colors.transparent],
                                            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                                          },
                                          blendMode: BlendMode.dstIn,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image(
                                          fit: BoxFit.fitWidth,
                                          image: NetworkImage('http://10.0.2.2:8000/image/${places[index].images[0]}')
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                              colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                                            ),
                                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                                            border: Border(
                                              left: BorderSide(color: Colors.white.withOpacity(0.5),),
                                              top: BorderSide(color: Colors.white.withOpacity(0.5),),
                                              bottom: BorderSide(color: Colors.white.withOpacity(0.5),),
                                            )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              places[index].name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'PoiretOne'
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    )
                  ],
                ),
              ),
            ), 
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    FocusScope.of(context).unfocus();
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
                  onMapReady: () {
                    Future.delayed(const Duration(seconds: 5)).then((v) {
                        setState(() {
                        isLoading = false;
                      });
                    });
                    
                  },
                  initialCenter: lat == null || long == null ? const LatLng(0, 0) : LatLng(lat!, long!),
                  initialZoom: 9.2
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=b82219592e7f48a9a0a219782320d3cc',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: List.generate(places.length, (int index) {
                      return Marker(
                        point: LatLng(places[index].position[0] , places[index].position[1]),
                        height: 50,
                        width: 50,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context, 
                              builder: (context) => placeDataSheet(context, places[index])
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                                  blurRadius: 10
                                )
                              ],
                              border: Border.all(color: Theme.of(context).primaryColorDark, width: 3)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage("http://10.0.2.2:8000/image/${places[index].images[0]}"),
                              ),
                            ),
                          ),
                        )
                      );
                    })
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Container(
                      color: Colors.grey.shade900.withOpacity(panelOpacity/1.4),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: !isLoading,
                    child: LoadingAnimation(colors: purplePalette, opacity: isLoading ? 1 : 0),
                  )
                ],
              ),
              slidingPanel(context)
          ],
        )
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}