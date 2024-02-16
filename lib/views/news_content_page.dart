import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/database/database.dart';

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
    return Consumer<List<SavedArticle>?>(builder: (context, value, child) {
      final selectedVal = value?.where((element) {
        return element.newsClass == newsClass;
      });

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
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    // value: 'Saved',
                    onTap: () {
                      if (selectedVal != null) {
                        if (selectedVal.isEmpty) {
                          context.read<AppDatabase>().addArticle(
                                SavedArticlesCompanion.insert(
                                  newsClass: newsClass,
                                ),
                              );
                        } else {
                          context
                              .read<AppDatabase>()
                              .deleteArticle(selectedVal.first.id);
                        }
                      }
                    },
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) {
                            if (selectedVal == null) {
                              return const Icon(Icons.bookmark_outline);
                            } else if (selectedVal.isEmpty) {
                              return const Icon(Icons.bookmark_outline);
                            } else {
                              return const Icon(Icons.bookmark);
                            }
                          },
                        ),
                        Builder(builder: (context) {
                          if (selectedVal == null) {
                            return const Text("Save");
                          } else if (selectedVal.isEmpty) {
                            return const Text("Save");
                          } else {
                            return const Text("Saved");
                          }
                        }),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
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
                    SelectableText(
                      newsClass.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.only(left: 8),
                child: Builder(builder: (context) {
                  final pubDate = newsClass.pubDate ?? '        ';
                  final formattedDate =
                      pubDate.substring(0, (pubDate.length - 6)).trim();
                  return SelectableText(formattedDate);
                }),
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
    });
  }
}
