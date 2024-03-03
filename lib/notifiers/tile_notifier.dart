import 'package:flutter/material.dart';
import 'package:that_app/database/database.dart';

class TileNotifier with ChangeNotifier {
  List<SavedArticle>? articlesList = [];

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
      // fill the bool list with true to select all
      tileValues = List.filled(articlesList!.length, true);
      // Add all articles
      selectedSavedArticles.addAll(articlesList!);
    }
    notifyListeners();
  }

  void removeAllArticles() {
    if (articlesList != null) {
      // fill the bool list with false to unselect all
      tileValues = List.filled(articlesList!.length, false);
      // Remove all articles
      selectedSavedArticles = [];
    }
    notifyListeners();
  }
}
