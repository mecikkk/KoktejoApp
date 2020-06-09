import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koktejo/constants.dart';
import 'package:koktejo/models/cocktail_model.dart';

class CardList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[

          SizedBox(height: 15.0),

          Container(
            padding: EdgeInsets.only(right: 15.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.width,
            child: GridView.count(crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.8,
            children: <Widget>[

              _buildCardView(CocktailModel('idd', 'Koktail2 bla bla bla', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123), false, context),
              _buildCardView(CocktailModel('idd', 'Koktail2dddsdfsdfsdfsdfsdf', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123), true, context),
              _buildCardView(CocktailModel('idd', 'Kopa labama drinkos alabama, heca kieca', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123), true, context),
              _buildCardView(CocktailModel('idd', 'Koktail2', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123), false, context),
              _buildCardView(CocktailModel('idd', 'Koktail2', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123), true, context),
              _buildCardView(CocktailModel('idd', 'Koktail2', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123), false, context),
              _buildCardView(CocktailModel('idd', 'Koktail2', 'saijdnaj', 'assets/kakao_daktyle.jpg', new List(2), new List(2), 123), false, context),



            ],),
          )

        ],
      ),
    );
  }

  buildTabContext(int count, List<CocktailModel> cocktails) => Container(
    child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return _buildCardView(cocktails[index], true, context);
        }),
  );

  Widget _buildCardView(CocktailModel cocktail, bool isFavourite, context) {
    return Padding(
      padding: EdgeInsets.all(7.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 4.0,
                blurRadius: 5.0
            )
          ],
          color: Theme.of(context).cardColor,
        ),
        child: Stack(
          children: <Widget>[
            Positioned (
              top: 0,
              left: 0,
              right: 0,
              height: 150,
              child: Hero(
                tag: cocktail.imgUrl,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          alignment: Alignment(0.0, 0.0),
                          image: AssetImage(cocktail.imgUrl),
                          fit: BoxFit.fitWidth,
                      )
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              height: 23.0,
              width: 23.0,
              child : Container(
                      decoration : BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              spreadRadius: 3.0,
                              blurRadius: 5.0
                          )
                        ],
                      )
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  isFavourite ? Icon(Icons.favorite, color: mAccentColor) :
                  Icon(Icons.favorite_border, color: mAccentColor)
                ],
              ),
            ),
            Positioned(
              bottom: 5,
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
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            )
          ],
        )
      ),
    );
  }

  Widget _buildCard(String name, String imgUrl, bool isFavourite, context) {

    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0
              )
            ],
            color: Colors.white70,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    isFavourite ? Icon(Icons.favorite, color: mAccentColor) :
                        Icon(Icons.favorite_border, color: mAccentColor)
                  ],
                ),
              ),
              Hero(
                tag: imgUrl,
                child: Container(
                  height: 100.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgUrl),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),

              SizedBox(height: 7.0)
            ],
          ),
        ),
      ),
    );

  }

}