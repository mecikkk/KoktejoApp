import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koktejo/constants.dart';
import 'package:koktejo/models/favourite_model.dart';
import 'package:koktejo/pages/favourites_page.dart';
import 'package:koktejo/providers/cocktails_info.dart';
import 'package:koktejo/providers/database_provider.dart';
import 'package:koktejo/providers/firestore_provider.dart';
import 'package:koktejo/widgets/card_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  TabController _tabController;
  final FirestoreProvider _firestore = new FirestoreProvider();
  final DatabaseProvider _databaseProvider = DatabaseProvider();
  var cocktailsInfo;

  bool allDataReceived = false;

  @override
  void initState() {
    cocktailsInfo = Provider.of<CocktailsInfo>(context, listen: false);
    _tabController = TabController(length: 0, vsync: this);
    _getCocktailsFromFirebase();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(widget.title, style: TextStyle(fontFamily: 'Varela', fontSize: 20.0)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border, color: mAccentColor),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FavouritesPage();
                }));
              },
            ),
          ],
        ),
        body: !allDataReceived ? _showLoading() : Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Kategorie',
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
              tabs: _createAllTabs(),
            ),
            Expanded(child : Container(
              height: 400,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: _createCocktailList(),
              ),
            )
            )
          ],
        )
    );
  }

  _showLoading() => Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(mAccentColor),
      )
  );

  List<Widget> _createCocktailList() {
    List<Widget> list = new List<Widget>();
    int index = 0;
    cocktailsInfo.categories.forEach((category) {
      list.add(CardList(index));
      index++;
    });

    return list;
  }

  List<Widget> _createAllTabs() {
    List<Widget> tabs = new List<Widget>();

    cocktailsInfo.categories.forEach((category) {
      tabs.add(_createTab(category.name));
    });

    return tabs;
  }

  _createTab(String title) => Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Tab(
          child: Text(
            title,
            style: TextStyle(fontSize: 19.0),
          ),
        ));

  Future<List<FavouriteModel>> getAllFavouriteCocktails() async {
    List<FavouriteModel> favourites = List<FavouriteModel>();

    favourites = await _databaseProvider.getAllFavourites();

    return favourites;
  }

  void _getCocktailsFromFirebase() {
    if(cocktailsInfo.categories.isEmpty) {
      _firestore.getCategories().then((categories) {
        cocktailsInfo.categories = categories;
      }).whenComplete(() {

        getAllFavouriteCocktails().then((favourites) {
          if(favourites.isNotEmpty) {
            cocktailsInfo.categories.forEach((category) {
              category.cocktails.forEach((cocktail) {
                favourites.forEach((favourite) {
                  if (favourite.cocktailId == cocktail.id) {
                    cocktail.isFavourite = true;
                    cocktailsInfo.myFavourites.add(cocktail);
                  }
                });
              });
            });
          }
          setState(() {
            allDataReceived = true;
            _tabController = new TabController(length: cocktailsInfo.categories.length, vsync: this);
          });
        });

      });
    }
  }
}
