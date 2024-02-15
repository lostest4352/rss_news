import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:that_app/notifiers/get_feed.dart';
import 'package:that_app/views/news_content_page.dart';

class NewsListPage extends StatelessWidget {
  final String siteTitle;
  const NewsListPage({
    Key? key,
    required this.siteTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(siteTitle),
      ),
      body: Consumer<GetFeed>(
        builder: (context, value, child) {
          if (value.newsClassList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 5,
                    );
                  },
                  itemCount: value.newsClassList.length,
                  itemBuilder: (context, index) {
                    final classList = value.newsClassList;
                    return SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: DesktopTextSelectionControls(),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NewsContentPage(
                                    newsClass: classList[index]);
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(classList[index].title),
                              subtitle: Builder(
                                builder: (context) {
                                  if (classList[index].description != null) {
                                    return Text(
                                      classList[index].description!,
                                      maxLines: 4,
                                    );
                                  } else {
                                    return const Center();
                                  }
                                },
                              ),
                            ),
                            //
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Builder(
                                builder: (context) {
                                  final xmlImageLink =
                                      classList[index].xmlImageLink;
                                  if (xmlImageLink != null) {
                                    return CachedNetworkImage(
                                      imageUrl: xmlImageLink,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Builder(
                                builder: (context) {
                                  final htmlImageLink =
                                      classList[index].htmlImageLink;
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
