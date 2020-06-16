import 'package:cloud_firestore/cloud_firestore.dart';

class CocktailModel {
  String _id;
  String _name;
  String _description;
  String _imgUrl;
  List<String> _ingredients;
  List<String> _tags;
  int _energy = 0;
  bool isFavourite;

  CocktailModel(this._id, this._name, this._description, this._imgUrl, this._ingredients, this._tags, this.isFavourite,
      [this._energy]);

  factory CocktailModel.fromFirestore(DocumentSnapshot dS) {
    Map data = dS.data;

    return CocktailModel(
        dS.documentID,
        data['name'],
        data['description'],
        data['imgUrl'],
        List<String>.from(dS.data['ingredients']),
        List<String>.from(data['tags']),
        false,
        0);
  }

  int get energy => _energy;

  List<String> get tags => _tags;

  List<String> get ingredients => _ingredients;

  String get description => _description;

  String get imgUrl => _imgUrl;

  String get name => _name;

  String get id => _id;
}
