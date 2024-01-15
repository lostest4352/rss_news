import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:that_app/models/news_class.dart';

class ContentPage extends StatelessWidget {
  final NewsClass newsClass;
  const ContentPage({
    Key? key,
    required this.newsClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Page"),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text(newsClass.title),
              subtitle: Text(newsClass.description ?? ""),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(child: Text(newsClass.content ?? "")),
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
