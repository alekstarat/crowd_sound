import 'dart:convert';

import 'package:database_repository/src/models/model.dart';

class UserModel implements Model {
  final int id;
  final String login, password, role;
  final List<dynamic> likedGroups, likedAudios, likedPlaces;

  const UserModel(
      {required this.id,
      required this.login,
      required this.password,
      required this.role,
      required this.likedAudios,
      required this.likedGroups,
      required this.likedPlaces});

  static const empty = UserModel(
      id: 0,
      login: "",
      password: "",
      role: "",
      likedAudios: [],
      likedGroups: [],
      likedPlaces: []
    );

  UserModel.fromJson(Map<String, Object?> v) : this(
    id : v["id"]! as int,
    login : v["login"]! as String,
    password:  v["password"]! as String,
    role: v['role']! as String,
    likedAudios: json.decode(v["liked_audios"] as String) as List<dynamic>,
    likedPlaces: json.decode(v["liked_places"] as String) as List<dynamic>,
    likedGroups: json.decode(v["liked_groups"] as String) as List<dynamic>,
  );

  @override
  UserModel copyWith({
    int? id,
    List<dynamic>? likedGroups,
    likedAudios,
    likedPlaces,
    String? login,
    password,
    role,
  }) {
    return UserModel(
        id: id ?? this.id,
        login: login ?? this.login,
        password: password ?? this.password,
        role: role ?? this.role,
        likedAudios: likedAudios ?? this.likedAudios,
        likedGroups: likedGroups ?? this.likedGroups,
        likedPlaces: likedPlaces ?? this.likedPlaces
      );
  }

  @override
  Map<String, Object?> toJson() {
    return {
      "id" : id,
      "login" : login,
      "password" : password,
      "role" : role,
      "liked_audios" : likedAudios,
      "liked_groups" : likedGroups,
      "liked_places" : likedPlaces
    };
  }

  @override
  String toString() {
    return "id : $id\nlogin : $login\nrole: $role";
  }
}
