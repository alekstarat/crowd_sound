//{"name":"Клуб Кинематограф","images":"[\"кинематограф.jpg\"]","events":"[1]","position":"[\"56.009144\", \"37.202790\"]","social":"[\"https://vk.com/kinematografclub\"]"}

import 'dart:convert';
import 'package:database_repository/src/models/model.dart';

class PlaceModel implements Model {

  final String name;
  final List<dynamic> images, social, events, position;

  PlaceModel({required this.name, required this.images, required this.social, required this.events, required this.position});

  static final empty = PlaceModel(
    name: "",
    images: [],
    social: [],
    events: [],
    position: []
  );

  PlaceModel.fromJson(Map<String, Object?> val) : this(
    name: val['name']! as String,
    images: json.decode(val['images'] as String) as List<dynamic>,
    social: json.decode(val['social'] as String) as List<dynamic>,
    events: json.decode(val['events'] as String) as List<dynamic>,
    position: json.decode(val['position'] as String) as List<dynamic>
  ); 

  @override
  Map<String, Object?> toJson() {
    return {
      'name' : name,
      'images' : images,
      'social' : social,
      'events' : events,
      'position' : position
    };
  }

  @override
  PlaceModel copyWith({
    String? name,
    List<dynamic>? images, social, events, position
  }) {
    return PlaceModel(
      name: name ?? this.name,
      images: images ?? this.images,
      social: json.decode(social) ?? this.social,
      events: events ?? this.events,
      position: position ?? this.position
    );
  }

  @override
  String toString() {
    return "name : $name\nimages : $images\nsocial : $social\nevents : $events\nposition : $position";
  }

}