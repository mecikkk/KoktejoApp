import 'package:flutter/material.dart';
import 'package:koktejo/widgets/card_list.dart';

import '../constants.dart';

class FavouritesPage extends StatefulWidget {


  FavouritesPage();

  @override
  State<StatefulWidget> createState() {
    return FavouritesPageState();
  }

}

class FavouritesPageState extends State<FavouritesPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Koktejo', style: TextStyle(fontFamily: 'Varela', fontSize: 20.0)),
        ),
        body: Stack(
          children: <Widget>[

            Positioned(
                top: 15,
                left: 20,
                child: Text('Polubione',
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold, color: mAccentColor), textAlign: TextAlign.left)),

            Positioned(
              top: 65.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: CardList.favouriteList(),
            )
          ],
        )

    );
  }

}