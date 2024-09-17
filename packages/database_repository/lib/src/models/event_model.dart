import 'dart:convert';

import 'package:database_repository/src/models/model.dart';

class EventModel implements Model{

  final String date, desc;
  final String? name;
  final List<dynamic> images;
  final int place;

  EventModel({required this.name, required this.date, required this.desc, required this.images, required this.place});



  static final empty = EventModel(
    name: "",
    images: [],
    date: "",
    desc: "",
    place: 0
  );

  EventModel.fromJson(Map<String, Object?> val) : this(
    name: val['name'] as String?,
    images: json.decode(val['images'] as String) as List<dynamic>,
    date: val['date']! as String,
    desc: json.decode(val['desc'] as String) as String,
    place: val['place']! as int
  ); 

  @override
  Map<String, Object?> toJson() {
    return {
      'name' : name,
      'images' : images,
      'date' : date,
      'desc' : desc,
      'place' : place
    };
  }
  
  @override
  EventModel copyWith({
    String? name, date, desc,
    List<dynamic>? images,
    int? place
  }) {
    return EventModel(
      name: name ?? this.name,
      images: images ?? this.images,
      date: date ?? this.date,
      desc: desc ?? this.desc,
      place: place ?? this.place
    );
  }

  @override
  String toString() {
    return "name : $name\nimages : $images\ndate : $date\ndesc : $desc\nplace : $place";
  }

}