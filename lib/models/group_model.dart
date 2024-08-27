import 'dart:convert';

class GroupModel {
  final String name;
  final String? desc;
  final List<dynamic> images, audios, events, social;

  GroupModel(
      {required this.name,
      required this.desc,
      required this.images,
      required this.audios,
      required this.events,
      required this.social});

  static final empty = GroupModel(
      name: "",
      desc: "",
      images: [],
      audios: [],
      events: [],
      social: [],
    );

  GroupModel.fromJson(Map<String, Object?> val) : this(
    name: val['name']! as String,
    desc: val['desc'] as String?,
    images: json.decode(val['images'] as String) as List<dynamic>, 
    audios: json.decode(val['audios'] as String) as List<dynamic>, 
    events: json.decode(val['events'] as String) as List<dynamic>, 
    social: json.decode(val['social'] as String) as List<dynamic>, 
  );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'images': images,
      'desc': desc,
      'audios' : audios,
      'events' : events,
      'social' : social
    };
  }

  GroupModel copyWith({
      String? desc, name, 
      List<dynamic>? images, audios, events, social, 
    }) {
    return GroupModel(
        name: name ?? this.name,
        images: images ?? this.images,
        audios: audios ?? this.audios,
        desc: desc ?? this.desc,
        events: events ?? this.events,
        social: social ?? this.social
      );
  }

  @override
  String toString() {
    return "name : $name\nimages : $images\nevents : $events\ndesc : $desc\naudios : $audios\nsocial : $social";
  }
}
