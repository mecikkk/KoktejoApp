
class CocktailModel {

  String _id;
  String _name;
  String _description;
  String _imgUrl;
  List<String> _ingredients;
  List<String> _tags;
  int _energy;

  CocktailModel(this._id, this._name, this._description, this._imgUrl, this._ingredients, this._tags,[ this._energy]);

  int get energy => _energy;

  List<String> get tags => _tags;

  List<String> get ingredients => _ingredients;

  String get description => _description;

  String get imgUrl => _imgUrl;

  String get name => _name;

  String get id => _id;
}