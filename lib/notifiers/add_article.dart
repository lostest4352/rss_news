import 'package:flutter/material.dart';

import 'package:that_app/database/database.dart';
import 'package:that_app/models/news_class.dart';

class AddArticle extends ChangeNotifier {
  final List<SavedArticle>? value;
  final NewsClass newsClass;

  AddArticle({
    required this.value,
    required this.newsClass,
  });

  Iterable<SavedArticle>? get selectedVal => value?.where((element) {
        return element.newsClass == newsClass;
      });
}
