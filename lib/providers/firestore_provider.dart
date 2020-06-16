import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koktejo/models/cocktail_category.dart';
import 'package:koktejo/models/cocktail_model.dart';

class FirestoreProvider {

  Firestore _firestore = Firestore.instance;

  Future<List<CocktailCategory>> getCategories() async {
    var categories = List<CocktailCategory>();

    var snapshot = await _firestore.collection('category').getDocuments();

    for(DocumentSnapshot snap in snapshot.documents) {
      var category = CocktailCategory(snap.documentID, snap.data['name']);
      var cocktails  = await getCocktailsByCategoryId(snap.documentID);

      category.cocktails = cocktails;

      categories.add(category);
    }

    categories.sort((a,b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return categories;
  }

  Future<List<CocktailModel>> getCocktailsByCategoryId(String categoryId) async {
    var cocktails = List<CocktailModel>();
    var snapshot = await _firestore.collection('category').document(categoryId).collection('cocktails').getDocuments();

    snapshot.documents.forEach((doc) {
      cocktails.add(CocktailModel.fromFirestore(doc));
    });

    return cocktails;
  }



}