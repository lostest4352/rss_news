import 'package:flutter/material.dart';

class NewsClass {
  final String title;
  final String? link;
  final String? description;
  final String? pubDate;
  final String? content;
  final String? imageLink;
  final Image? imageContent;

  NewsClass({
    required this.title,
    required this.link,
    required this.description,
    required this.pubDate,
    required this.content,
    required this.imageLink,
    required this.imageContent,
  });
}
