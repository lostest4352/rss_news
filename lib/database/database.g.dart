// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SavedArticlesTable extends SavedArticles
    with TableInfo<$SavedArticlesTable, SavedArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _newsClassMeta =
      const VerificationMeta('newsClass');
  @override
  late final GeneratedColumnWithTypeConverter<NewsClass, String> newsClass =
      GeneratedColumn<String>('news_class', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<NewsClass>($SavedArticlesTable.$converternewsClass);
  @override
  List<GeneratedColumn> get $columns => [id, newsClass];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_articles';
  @override
  VerificationContext validateIntegrity(Insertable<SavedArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_newsClassMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedArticle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      newsClass: $SavedArticlesTable.$converternewsClass.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}news_class'])!),
    );
  }

  @override
  $SavedArticlesTable createAlias(String alias) {
    return $SavedArticlesTable(attachedDatabase, alias);
  }

  static TypeConverter<NewsClass, String> $converternewsClass =
      const NewsClassConverter();
}

class SavedArticle extends DataClass implements Insertable<SavedArticle> {
  final int id;
  final NewsClass newsClass;
  const SavedArticle({required this.id, required this.newsClass});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['news_class'] = Variable<String>(
          $SavedArticlesTable.$converternewsClass.toSql(newsClass));
    }
    return map;
  }

  SavedArticlesCompanion toCompanion(bool nullToAbsent) {
    return SavedArticlesCompanion(
      id: Value(id),
      newsClass: Value(newsClass),
    );
  }

  factory SavedArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedArticle(
      id: serializer.fromJson<int>(json['id']),
      newsClass: serializer.fromJson<NewsClass>(json['newsClass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'newsClass': serializer.toJson<NewsClass>(newsClass),
    };
  }

  SavedArticle copyWith({int? id, NewsClass? newsClass}) => SavedArticle(
        id: id ?? this.id,
        newsClass: newsClass ?? this.newsClass,
      );
  @override
  String toString() {
    return (StringBuffer('SavedArticle(')
          ..write('id: $id, ')
          ..write('newsClass: $newsClass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, newsClass);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedArticle &&
          other.id == this.id &&
          other.newsClass == this.newsClass);
}

class SavedArticlesCompanion extends UpdateCompanion<SavedArticle> {
  final Value<int> id;
  final Value<NewsClass> newsClass;
  const SavedArticlesCompanion({
    this.id = const Value.absent(),
    this.newsClass = const Value.absent(),
  });
  SavedArticlesCompanion.insert({
    this.id = const Value.absent(),
    required NewsClass newsClass,
  }) : newsClass = Value(newsClass);
  static Insertable<SavedArticle> custom({
    Expression<int>? id,
    Expression<String>? newsClass,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (newsClass != null) 'news_class': newsClass,
    });
  }

  SavedArticlesCompanion copyWith(
      {Value<int>? id, Value<NewsClass>? newsClass}) {
    return SavedArticlesCompanion(
      id: id ?? this.id,
      newsClass: newsClass ?? this.newsClass,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (newsClass.present) {
      map['news_class'] = Variable<String>(
          $SavedArticlesTable.$converternewsClass.toSql(newsClass.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedArticlesCompanion(')
          ..write('id: $id, ')
          ..write('newsClass: $newsClass')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $SavedArticlesTable savedArticles = $SavedArticlesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [savedArticles];
}
