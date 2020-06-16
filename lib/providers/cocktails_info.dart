import 'package:flutter/foundation.dart';
import 'package:koktejo/models/cocktail_category.dart';
import 'package:koktejo/models/cocktail_model.dart';

class CocktailsInfo extends ChangeNotifier {

  List<CocktailCategory> _categories = List<CocktailCategory>();
  List<CocktailModel> _myFavourites = List<CocktailModel>();

  List<CocktailCategory> get categories => _categories;

  List<CocktailModel> get myFavourites => _myFavourites;


  set categories(List<CocktailCategory> value) {
    _categories = value;
  }

  set myFavourites(List<CocktailModel> value) {
    _myFavourites = value;
  }

  addToFavourites(CocktailModel cocktail) {

    _myFavourites.add(cocktail);
    _categories.forEach((element) {
      var result = element.getCocktailById(cocktail);
      if(result != null)
        result.isFavourite = true;
    });

    notifyListeners();
  }

  removeFromFavourites(CocktailModel cocktail) {
    _myFavourites.remove(cocktail);
    _categories.forEach((element) {
      var result = element.getCocktailById(cocktail);
      if(result != null)
        result.isFavourite = false;
    });

    notifyListeners();
  }
}