import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koktejo/models/cocktail_model.dart';
import 'package:koktejo/models/favourite_model.dart';
import 'package:koktejo/providers/cocktails_info.dart';
import 'package:koktejo/providers/database_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class DetailsPage extends StatefulWidget {
  final CocktailModel _cocktail;

  DetailsPage(this._cocktail);

  @override
  State<StatefulWidget> createState() {
    return DetailsPageState();
  }
}

class DetailsPageState extends State<DetailsPage> {

  var cocktailsInfo;

  @override
  void initState() {
    cocktailsInfo = Provider.of<CocktailsInfo>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget._cocktail.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset.zero,
                              blurRadius: 15.0
                          )
                        ],
                      color: Colors.white
                    ),
              ),
              titlePadding: EdgeInsets.only(left : 15.0, bottom: 15.0),
              background: _buildHero(),
           ),
            actions: <Widget>[
             IconButton(
                icon: widget._cocktail.isFavourite ? Icon(Icons.favorite, color: mAccentColor) : Icon(Icons.favorite_border, color: mAccentColor),
                onPressed: () {
                  widget._cocktail.isFavourite = !widget._cocktail.isFavourite;
                  if(widget._cocktail.isFavourite){
                    DatabaseProvider().addToFavourites(FavouriteModel(widget._cocktail.id));
                    cocktailsInfo.addToFavourites(widget._cocktail);
                  } else {
                    DatabaseProvider().removeFromFavourites(widget._cocktail.id);
                    cocktailsInfo.removeFromFavourites(widget._cocktail);
                  }
                  setState(() {

                  });
              }),
           ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(left : 20.0, top : 25.0),
                  child: Text('Składniki',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: mAccentColor
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left : 20.0, top : 5.0, right: 20.0),
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: Theme.of(context).cardColor.withOpacity(0.1),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left : 15.0, top : 15.0),
                  child: getIngredientsList()
                ),

                Padding(
                  padding: EdgeInsets.only(left : 20.0, top : 25.0),
                  child: Text('Opis',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: mAccentColor
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left : 20.0, top : 5.0, right: 20.0),
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: Theme.of(context).cardColor.withOpacity(0.1),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    widget._cocktail.description,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ]
            ),
          )
        ],
     )
    );
  }

  Widget _buildHero() {

    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Hero(
              tag: widget._cocktail.imgUrl,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)
                ),
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image : widget._cocktail.imgUrl,
                    fit: BoxFit.cover
                ),
              )
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          height: 40.0,
          child: Container(
              decoration : BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 15.0,
                      blurRadius: 25.0
                  )
                ],
              )
          ),
        )
      ],
    );
  }

  Column getIngredientsList() {
    List<Widget> ingredients = List<Widget>();

    for(String ingredient in widget._cocktail.ingredients){
      ingredients.add(
        Padding(
          padding: EdgeInsets.only(left: 25.0, top: 7.5),
          child: Text('• ' + ingredient,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
              )
          ),
        )
      );
    }

    return Column(
      children: ingredients,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

}
