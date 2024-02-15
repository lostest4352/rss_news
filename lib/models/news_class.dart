import 'dart:convert';

import 'package:flutter/widgets.dart';

class NewsClass {
  final String title;
  final String? link;
  final String? description;
  final String? pubDate;
  final String? content;
  final String? htmlImageLink;
  final String? xmlImageLink;
  final String? creator;

  NewsClass({
    required this.title,
    required this.link,
    required this.description,
    required this.pubDate,
    required this.content,
    required this.htmlImageLink,
    required this.xmlImageLink,
    required this.creator,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'link': link,
      'description': description,
      'pubDate': pubDate,
      'content': content,
      'htmlImageLink': htmlImageLink,
      'xmlImageLink': xmlImageLink,
      'creator': creator,
    };
  }

  factory NewsClass.fromMap(Map<String, dynamic> map) {
    return NewsClass(
      title: map['title'] ?? '',
      link: map['link'],
      description: map['description'],
      pubDate: map['pubDate'],
      content: map['content'],
      htmlImageLink: map['htmlImageLink'],
      xmlImageLink: map['xmlImageLink'],
      creator: map['creator'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsClass.fromJson(String source) =>
      NewsClass.fromMap(json.decode(source));

  NewsClass copyWith({
    String? title,
    ValueGetter<String?>? link,
    ValueGetter<String?>? description,
    ValueGetter<String?>? pubDate,
    ValueGetter<String?>? content,
    ValueGetter<String?>? htmlImageLink,
    ValueGetter<String?>? xmlImageLink,
    ValueGetter<String?>? creator,
  }) {
    return NewsClass(
      title: title ?? this.title,
      link: link != null ? link() : this.link,
      description: description != null ? description() : this.description,
      pubDate: pubDate != null ? pubDate() : this.pubDate,
      content: content != null ? content() : this.content,
      htmlImageLink:
          htmlImageLink != null ? htmlImageLink() : this.htmlImageLink,
      xmlImageLink: xmlImageLink != null ? xmlImageLink() : this.xmlImageLink,
      creator: creator != null ? creator() : this.creator,
    );
  }

  @override
  String toString() {
    return 'NewsClass(title: $title, link: $link, description: $description, pubDate: $pubDate, content: $content, htmlImageLink: $htmlImageLink, xmlImageLink: $xmlImageLink, creator: $creator)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsClass &&
        other.title == title &&
        other.link == link &&
        other.description == description &&
        other.pubDate == pubDate &&
        other.content == content &&
        other.htmlImageLink == htmlImageLink &&
        other.xmlImageLink == xmlImageLink &&
        other.creator == creator;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        link.hashCode ^
        description.hashCode ^
        pubDate.hashCode ^
        content.hashCode ^
        htmlImageLink.hashCode ^
        xmlImageLink.hashCode ^
        creator.hashCode;
  }
}
