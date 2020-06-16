import 'package:koktejo/models/cocktail_model.dart';

class CocktailCategory {

  final String _id;
  final String _name;
  List<CocktailModel> _cocktails;

  CocktailCategory(this._id, this._name);

  String get name => _name;

  String get id => _id;

  List<CocktailModel> get cocktails => _cocktails;

  set cocktails(List<CocktailModel> value) {
    _cocktails = value;
  }

  CocktailModel getCocktailById(CocktailModel cocktail) {
    cocktails.forEach((element) {
      if(element.id == cocktail.id) return element;
      else return null;
    });

    return null;
  }
}