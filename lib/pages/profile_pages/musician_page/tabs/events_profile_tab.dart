import 'package:crowd_sound/pages/profile_pages/musician_page/components/profile_event_tile.dart';
import 'package:flutter/material.dart';

class EventsProfileTab extends StatefulWidget {

  final List<dynamic> events;

  const EventsProfileTab({super.key, required this.events});

  @override
  State<EventsProfileTab> createState() => _EventsProfileTabState();
}

class _EventsProfileTabState extends State<EventsProfileTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.05),
        child: Column( 
          children: List.generate(widget.events.length, (int index) => ProfileEventTile(id: widget.events[index]))
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}