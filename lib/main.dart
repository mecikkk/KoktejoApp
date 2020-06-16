import 'package:flutter/material.dart';
import 'package:koktejo/constants.dart';
import 'package:koktejo/pages/home_page.dart';
import 'package:koktejo/providers/cocktails_info.dart';
import 'package:provider/provider.dart';

void main() => runApp(KoktejoApp());

class KoktejoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koktejo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: mAccentColor,
        primaryColorBrightness: Brightness.light,
        cardColor: Color.fromRGBO(240, 240, 240, 1.0),
        fontFamily: 'Varela'
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: mAccentColor,
        primaryColorBrightness: Brightness.dark,
        cardColor: Colors.black38,
          fontFamily: 'Varela'
      ),
      home: ChangeNotifierProvider(
        create: (context) => CocktailsInfo(),
        child: HomePage(title: 'Koktejo'),
      )
    );
  }
}


