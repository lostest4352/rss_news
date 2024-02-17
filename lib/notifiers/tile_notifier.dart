import 'package:flutter/material.dart';
import 'package:that_app/database/database.dart';

// TODO
class TileNotifier with ChangeNotifier {
  final List<SavedArticle>? articlesList;

  TileNotifier({required this.articlesList});

  List<SavedArticle> selectedSavedArticles = [];

  List<bool> tileValues = [];

  void insertTileVals() {
    if (articlesList != null) {
      tileValues = List.filled(articlesList!.length, false);
    }
    notifyListeners();
  }

  void changeValues(int index) {
    tileValues[index] = !tileValues[index];

    // Add or remove item
    if (articlesList != null) {
      if (tileValues[index] == true) {
        selectedSavedArticles.add(articlesList![index]);
      } else {
        selectedSavedArticles.remove(articlesList![index]);
      }
    }
    notifyListeners();
  }

  void addAllArticles() {
    if (articlesList != null) {
      // fill the bool list
      tileValues = List.filled(articlesList!.length, true);
      // Add all articles
      selectedSavedArticles.addAll(articlesList!);
    }
  }

  void removeAllArticles() {
    if (articlesList != null) {
      // fill the bool list
      tileValues = List.filled(articlesList!.length, false);
      // Add all articles
      selectedSavedArticles = [];
    }
  }
}
