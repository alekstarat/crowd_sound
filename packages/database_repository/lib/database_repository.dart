import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:database_repository/src/models/model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseRepository {

  final Dio dio  = Dio();
  int? userId;
  bool? isAuthenticated;
  bool prefsInited = false;
  late final SharedPreferences _prefs;
  UserModel userModel = UserModel.empty;

  UserModel get user => userModel;

  DatabaseRepository({this.userId});


  // Handling auth data

  Future<void> logout() async {
    _prefs.remove("user_id");
    userModel = UserModel.empty;
  }

  Future<bool> registration(String login, String password) async {
    List<int> bytes = utf8.encode(password);
    String hashedPassword = sha256.convert(bytes).toString();
    dynamic res = await dio.post("http://10.0.2.2:8000/registration?login=$login&password=$hashedPassword");
    if (res.data["message"] == "Что-то пошло не так") {
      return false;
    }
    _prefs.setInt("user_id", res.data["user_id"]);
    dynamic v = await dio.get('http://10.0.2.2:8000/user/${res.data["user_id"]}');
    userModel = UserModel.fromJson(v.data);
    return true;
  }

  Future<bool> authenticate(String login, String password) async {
    dynamic response;
    List<int> bytes = utf8.encode(password);
    String hashedPassword = sha256.convert(bytes).toString();
    try {
      response = await dio.post('http://10.0.2.2:8000/login?login=$login&password=$hashedPassword');
    } catch (e) {
      return false;
    }
    if (response.data['message'] == "Успешный вход") {
      _prefs.setInt("user_id", response.data['id']);
      dynamic v = await dio.get('http://10.0.2.2:8000/user/${response.data['id']}');
      userModel = UserModel.fromJson(v.data);
      return true;
    }
    return false;
  }

  Future<bool> getAuthenctiactionData() async {
    _prefs = await SharedPreferences.getInstance();
    userId = _prefs.getInt("user_id");
    if (userId != 0 && userId != null) {
      dynamic v = await dio.get('http://10.0.2.2:8000/user/$userId');
      userModel = UserModel.fromJson(v.data);
      return true;
    } else {
      return false;
    }
  }

  // Handling models data

  Future<List<PlaceModel>> getPlacesList() async {

    List<PlaceModel> res = [];

    try {
      dynamic places = await dio.get("http://10.0.2.2:8000/places");
      res = List.generate(places.data["data"].length, (int index) {
        return PlaceModel.fromJson(places.data["data"][index]);
      });
    } catch (e) {
      print(e);
    }
    return res;
  }


  Future<PlaceModel> getPlaceModelData(int placeId) async {
    try {
      var res = await dio.get("http://10.0.2.2:8000/place/$placeId");
      return PlaceModel.fromJson(res.data);
    } catch (e) {
      return PlaceModel.empty;
    }
  }

  Future<EventModel> getEventModelData(int eventId) async {
    try {
      var res = await dio.get("http://10.0.2.2:8000/event/$eventId");
      return EventModel.fromJson(res.data);
    } catch (e) {
      return EventModel.empty;
    }
  }

  Future<GroupModel> getGroupModelData(int groupId) async {
    try {
      var res = await dio.get("http://10.0.2.2:8000/group/$groupId");
      return GroupModel.fromJson(res.data);
    } catch (e) {
      return GroupModel.empty;
    } 
  }
}