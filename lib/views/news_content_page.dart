import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:that_app/models/news_class.dart';

class NewsContentPage extends StatelessWidget {
  final NewsClass newsClass;
  const NewsContentPage({
    Key? key,
    required this.newsClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          newsClass.title,
          style: const TextStyle(overflow: TextOverflow.fade),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.black26,
              padding: const EdgeInsets.all(8),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    newsClass.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  final imgLink = newsClass.imageLink;
                  if (imgLink != null) {
                    return CachedNetworkImage(
                      imageUrl: imgLink,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                    );
                  } else {
                    return const Center();
                  }
                },
              ),
            ),
            SizedBox(
              child: Builder(
                builder: (context) {
                  String textToShow = '';
                  final description = newsClass.description;
                  final content = newsClass.content;

                  if (content != null) {
                    textToShow = content;
                  } else if (content == null && description != null) {
                    textToShow = description;
                  } else {
                    textToShow = '';
                  }
                  return ColoredBox(
                    color: Colors.black45,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(textToShow),
                    ),
                  );
                },
              ),
            ),
            Builder(
              builder: (context) {
                final imgLink = newsClass.innerImageLink;
                if (imgLink != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: imgLink,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                    ),
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
