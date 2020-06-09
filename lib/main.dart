import 'package:flutter/material.dart';
import 'package:koktejo/constants.dart';
import 'package:koktejo/pages/home_page.dart';

void main() => runApp(KoktejoApp());

class KoktejoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koktejo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        cardColor: Colors.white70,
        fontFamily: 'Varela'
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
        cardColor: Colors.black45,
          fontFamily: 'Varela'
      ),
      home: HomePage(title: 'Koktejo'),
    );
  }
}


