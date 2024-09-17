import 'package:crowd_sound/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init.initMapkit(
    apiKey: "a3eda23b-5a82-487c-ac52-e2bde76a8d5b"
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final DatabaseRepository dataRepo = DatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => dataRepo,
      child: const App(),
    );
  }
}
