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
    this.creator,
  });
}
