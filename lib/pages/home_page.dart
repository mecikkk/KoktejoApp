import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koktejo/constants.dart';
import 'package:koktejo/models/cocktail_model.dart';
import 'package:koktejo/widgets/card_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
            onPressed: () {},
          ),
          title: Text(widget.title, style: TextStyle(fontFamily: 'Varela', fontSize: 20.0)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
        body: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Koktajle',
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold,), textAlign: TextAlign.left)),
            SizedBox(height: 15.0),
            TabBar(
              controller: _tabController,
              indicatorColor: mAccentColor,
              indicatorPadding: EdgeInsets.only(left: 30.0, right: 30.0),
              labelColor: mAccentColor,
              isScrollable: true,
              unselectedLabelColor: mDisabledAccentColor,
              labelPadding: EdgeInsets.only(right: 25.0),
              tabs: <Widget>[
                _createTab('Na śniadanie'),
                _createTab('Odchudzające'),
                _createTab('Pobudzające'),
                _createTab('Oczyszczające'),
                _createTab('Odmładzające')
              ],
            ),
            Expanded(child : Container(
              height: 400,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  CardList(_dummyCocktailList()),
                  CardList(_dummyCocktailList()),
                  CardList(_dummyCocktailList()),
                  CardList(_dummyCocktailList()),
                  CardList(_dummyCocktailList()),
                ],
              ),
            )
            )
          ],
        )
    );
  }

  _dummyCocktailList() {
    var cocktails = new List<CocktailModel>();
    cocktails.add(CocktailModel('idd', 'Koktail1', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123));
    cocktails.add(CocktailModel('idd', 'Koktail2 ', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123));
    cocktails.add(CocktailModel('idd', 'Koktail3 bla bla bla', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123));
    cocktails.add(CocktailModel('idd', 'Koktail4 bla bla bla', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123));
    cocktails.add(CocktailModel('idd', 'Koktail5 bla bla bla', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123));
    cocktails.add(CocktailModel('idd', 'Koktail2 bla bla bla', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123));
    cocktails.add(CocktailModel('idd', 'Koktail67 bla bla bla', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123));
    cocktails.add(CocktailModel('idd', 'Koktail2 bla bla bla', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123));

    return cocktails;
  }


  _createTab(String title) => Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Tab(
          child: Text(
            title,
            style: TextStyle(fontSize: 19.0),
          ),
        ));

}
