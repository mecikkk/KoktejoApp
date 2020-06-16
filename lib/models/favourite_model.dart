class FavouriteModel {

  int _id;
  String _cocktailId;

  FavouriteModel(this._cocktailId);

  String get cocktailId => _cocktailId;

  int get id => _id;

  FavouriteModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._cocktailId = map['cocktailId'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = _id;
    map['cocktailId'] = _cocktailId;

    return map;
  }
}