import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:koktejo/models/favourite_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {

  static DatabaseProvider _databaseProvider;
  static Database _database;

  String favouritesTable = 'favourites_table';
  String colId = 'id';
  String colCocktailId = 'cocktailId';


  DatabaseProvider._createInstance();

  factory DatabaseProvider() {
    if(_databaseProvider == null) _databaseProvider = DatabaseProvider._createInstance();
    return _databaseProvider;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $favouritesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCocktailId TEXT)');
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'favourites.db';

    var notesDatabase = await openDatabase(path, version: 2, onCreate: _createDb);
    return notesDatabase;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }

    return _database;
  }


  Future<List<Map<String, dynamic>>> _getFavouritesMapList() async {

    Database db = await this.database;

    var result = await db.query(favouritesTable, orderBy: '$colId ASC');
    return result;
  }


  Future<int> addToFavourites(FavouriteModel favourite) async {
    Database db = await this.database;

    var result = await db.insert(favouritesTable, favourite.toMap());
    debugPrint("DB insert result : $result");
    return result;
  }


  Future<int> removeFromFavourites(String cocktailId) async {
    var db = await this.database;

    var result = await db.delete(favouritesTable, where: '$colCocktailId LIKE \'$cocktailId\'');
    return result;
  }

  Future<int> getCount() async {
    var db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $favouritesTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<FavouriteModel>> getAllFavourites() async {

    var noteMapList = await _getFavouritesMapList();
    int count = noteMapList.length;

    List<FavouriteModel> noteList = List<FavouriteModel>();

    for(int i = 0; i < count; i++){
      debugPrint("MapList : ${noteMapList[i]}");
      noteList.add(FavouriteModel.fromMapObject(noteMapList[i]));
    }

    return noteList;

  }

}