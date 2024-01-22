import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:that_app/models/news_class.dart';
import 'package:url_launcher/link.dart';

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
          () {
            final creator = newsClass.creator;
            if (creator != null) {
              return "From: $creator";
            } else {
              return newsClass.title;
            }
          }(),
          // newsClass.creator ?? newsClass.title,
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
              padding: const EdgeInsets.only(left: 8, top: 6),
              // child: SelectableText(
              //   newsClass.link ?? "",
              //   style: const TextStyle(color: Colors.blue),
              // ),
              // TODO android
              child: Link(
                uri: Uri.parse(newsClass.link ?? ""),
                builder: (context, followLink) {
                  return InkWell(
                    onTap: followLink,
                    child: Text(
                      newsClass.link ?? "",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  );
                },
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  final htmlImageLink = newsClass.htmlImageLink;
                  if (htmlImageLink != null) {
                    return CachedNetworkImage(
                      imageUrl: htmlImageLink,
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
            Builder(
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
            Builder(
              builder: (context) {
                final xmlImageLink = newsClass.xmlImageLink;
                if (xmlImageLink != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: xmlImageLink,
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
