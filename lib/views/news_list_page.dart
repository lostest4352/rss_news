import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/services/get_feed.dart';
import 'package:that_app/views/news_content_page.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Lists"),
      ),
      body: Consumer<GetFeed>(
        builder: (context, value, child) {
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
                    if (classList.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: DesktopTextSelectionControls(),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return NewsContentPage(
                                  newsClass: classList[index]);
                            },
                          ));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(classList[index].title),
                              subtitle: Builder(
                                builder: (context) {
                                  if (classList[index].description != null) {
                                    return Text(classList[index].description!);
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
                                  final imgLink = classList[index].imageLink;
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Builder(
                                builder: (context) {
                                  final imgLink =
                                      classList[index].innerImageLink;
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