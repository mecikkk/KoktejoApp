import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:koktejo/constants.dart';
import 'package:koktejo/models/cocktail_model.dart';
import 'package:koktejo/models/favourite_model.dart';
import 'package:koktejo/pages/details_page.dart';
import 'package:koktejo/providers/database_provider.dart';

class CardList extends StatefulWidget {

  final List<CocktailModel> _cocktails;
  final List<CocktailModel> _myFavourites;

  CardList(this._cocktails, [this._myFavourites]);

  @override
  State<StatefulWidget> createState() {
    return CardListState(_cocktails);
  }
}

class CardListState extends State<CardList> {

  final DatabaseProvider _databaseProvider = DatabaseProvider();

  final List<CocktailModel> _cocktails;
  bool darkMode = false;

  CardListState(this._cocktails);

  @override
  void initState() {
    super.initState();

    var brightness = SchedulerBinding.instance.window.platformBrightness;
    darkMode = brightness == Brightness.dark;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        //padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[

          //SizedBox(height: 15.0),

          Positioned(
            top: 15.0,
            right: 15.0,
            left: 15.0,
            bottom: 0.0,
            child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: _buildAllCards(context)),
          )

        ],
      ),
    );
  }

  List<Widget> _buildAllCards(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    int index = 0;
    for(CocktailModel cocktail in _cocktails) {
      widgets.add(_buildCardView(index, cocktail, true, context));
      index++;
    }
    return widgets;
  }

  Widget _buildCardView(int index, CocktailModel cocktail, bool isFavourite, context) {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailsPage(cocktail);
              }
            ));
          },
          child :  Container(
            decoration: _cardBackground(context),
            child: Stack(
              children: <Widget>[

                _heroImage(cocktail),

                _favouriteIconShadow(),

                _favouriteIcon(cocktail),

                _cardTitle(context, cocktail)
              ],
           )
        )
      ),
    );
  }


  BoxDecoration _cardBackground(BuildContext context) => BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2.0,
          blurRadius: 6.0
      )
    ],
    color: Theme.of(context).cardColor,
  );

  Widget _heroImage(CocktailModel cocktail) => Positioned (
    top: 0,
    left: 0,
    right: 0,
    height: 150,
    child : Hero(
        tag: cocktail.imgUrl,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage.assetNetwork(
                placeholder: darkMode ? 'assets/placeholder.png' : 'assets/placeholder_light.png',
                image : cocktail.imgUrl,
              fit: BoxFit.cover
            ),
        ),
    ),
  );

  Widget _favouriteIconShadow() => Positioned(
    right: 5,
    top: 5,
    height: 23.0,
    width: 23.0,
    child : Container(
        decoration : BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3.0,
                blurRadius: 5.0
            )
          ],
        )
    ),
  );

  Widget _favouriteIcon(CocktailModel cocktail) {

    return GestureDetector(
      onTap: () {

        if(!cocktail.isFavourite)  {
          _addToFavourites(cocktail.id).then((success) {
            setState(()  {
              cocktail.isFavourite = true;
              widget._myFavourites.add(cocktail);
            });
          });
        } else {
          _removeFromFavourites(cocktail.id).then((success) {
            setState(()  {
              cocktail.isFavourite = false;
              widget._myFavourites.remove(cocktail);
            });
          });
        }


      },
      child: Padding(
        padding: EdgeInsets.all(
            5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            cocktail.isFavourite ? Icon(
                Icons.favorite, color: mAccentColor) :
            Icon(
                Icons.favorite_border, color: mAccentColor)
          ],
        ),
      ),
    );
  }
  
  Future<bool> _addToFavourites(String cocktailId) async {
    int result = await _databaseProvider.addToFavourites(FavouriteModel(cocktailId));

    if(result != 0) return true;
    else return false;
  }

  Future<bool> _removeFromFavourites(String cocktailId) async {
    int result = await _databaseProvider.removeFromFavourites(cocktailId);

    if(result != 0) return true;
    else return false;
  }

    Positioned _cardTitle(BuildContext context, CocktailModel cocktail) => Positioned(
        bottom: 7,
        left: 0,
        right: 0,
        child: Container(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width - 30,
                maxWidth: MediaQuery.of(context).size.width - 30,
                maxHeight: 55.0,
                minHeight: 30.0
            ),
            child: Text(
              cocktail.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        )
    );

}