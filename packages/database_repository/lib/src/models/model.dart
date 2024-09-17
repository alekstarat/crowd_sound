
export 'package:database_repository/src/models/place_model.dart';
export 'package:database_repository/src/models/group_model.dart';
export 'package:database_repository/src/models/event_model.dart';
export 'package:database_repository/src/models/user_model.dart';

abstract class Model {

  Model.fromJson(Map<String, Object?> v);

  Map<String, Object?> toJson();

  Model copyWith();

  @override
  String toString();

}