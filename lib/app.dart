import 'package:crowd_sound/feauters/auth/auth_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(38, 31, 56, 1),
        primaryColor: Colors.white,
        secondaryHeaderColor: const Color.fromRGBO(114, 40, 218, 1),
        primaryColorDark: const Color.fromRGBO(100, 32, 55, 1),
        primaryColorLight: const Color.fromRGBO(226, 86, 90, 1),
        focusColor: const Color.fromRGBO(70, 239, 238, 1)
      ),
      home: const AuthPage(),
    );
  }
}