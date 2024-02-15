import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/database/database.dart';
import 'package:that_app/views/appdrawer.dart';
import 'package:that_app/views/news_content_page.dart';

class OfflineArticlesPage extends StatelessWidget {
  const OfflineArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Articles"),
      ),
      drawer: const AppDrawer(),
      body: Consumer<List<SavedArticle>?>(
        builder: (context, value, child) {
          if (value == null || value.isEmpty) {
            return const Center(
              child: Text("No articles saved"),
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
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final classList = value;
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
                                    newsClass: classList[index].newsClass);
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(classList[index].newsClass.title),
                              subtitle: Builder(
                                builder: (context) {
                                  if (classList[index].newsClass.description !=
                                      null) {
                                    return Text(
                                      classList[index].newsClass.description!,
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
                                      classList[index].newsClass.xmlImageLink;
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
                                      classList[index].newsClass.htmlImageLink;
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
