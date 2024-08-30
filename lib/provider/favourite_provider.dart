import 'package:db_minor/model/jsonmodel.dart';
import 'package:flutter/material.dart';

import '../model/helper/database.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Jsonmodel> likedList = [];

  FavouriteProvider() {
    // Load initial data from the database when the provider is created.
    _loadLikedQuotes();
  }

  Future<void> _loadLikedQuotes() async {
    likedList = await DbHelper.dbHelper.getAllData();
    notifyListeners();
  }

  bool isLiked(Jsonmodel model) {
    return likedList.any((item) => item.id == model.id);
  }

  Future<void> like({required Jsonmodel model}) async {
    if (!isLiked(model)) {
      await DbHelper.dbHelper.addDb(model.quote, model.author);
      likedList.add(model);
      notifyListeners();
    }
  }

  Future<void> disLike({required Jsonmodel model}) async {
    if (isLiked(model)) {
      await DbHelper.dbHelper.removeDB(model.id);
      likedList.removeWhere((item) => item.id == model.id);
      notifyListeners();
    }
  }
}
