import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:that_app/models/news_class.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class SavedArticles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get newsClass => text().map(const NewsClassConverter())();
}

@DriftDatabase(tables: [SavedArticles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<SavedArticle>> getData() async {
    List<SavedArticle> allArticles = await select(savedArticles).get();
    return allArticles;
  }

  Stream<List<SavedArticle>> getDataStream() async* {
    final allArticles = (select(savedArticles)
          ..orderBy(
              [(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
        .watch();
    yield* allArticles;
  }

  Future<int> addArticle(SavedArticlesCompanion entry) {
    final addEntry = into(savedArticles).insert(entry);
    return addEntry;
  }

  //
  Future<int> createOrUpdateArticle(SavedArticle article) {
    return into(savedArticles).insertOnConflictUpdate(article);
  }

  Future<int> deleteArticle(int articleId) {
    final deleteEntry =
        (delete(savedArticles)..where((tbl) => tbl.id.equals(articleId))).go();
    return deleteEntry;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final docDir = await getApplicationDocumentsDirectory();
    // final file = File(p.join(dbFolder.path, 'db.sqlite'));
    final dbFolder = Directory(p.join(docDir.path, 'newsappdb'));
    await dbFolder.create(recursive: true);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    debugPrint(dbFolder.path);

    return NativeDatabase.createInBackground(file);
  });
}

// Class Converter
class NewsClassConverter extends TypeConverter<NewsClass, String> {
  const NewsClassConverter();

  @override
  NewsClass fromSql(String fromDb) {
    // debugPrint(" here is $fromDb");
    return NewsClass.fromMap(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(NewsClass value) {
    return json.encode(value.toMap());
    // return value.toJson();
  }
}
