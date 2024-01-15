import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:that_app/services/get_feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetFeed getFeed = GetFeed();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("That App"),
      ),
      body: ListenableBuilder(
        listenable: getFeed,
        builder: (context, child) {
          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      getFeed.getData(
                          "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml");
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      getFeed.getData('https://www.onlinekhabar.com/feed');
                    },
                    icon: const Icon(Icons.newspaper_rounded),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: getFeed.newsClassList.length,
                  itemBuilder: (context, index) {
                    final classList = getFeed.newsClassList;
                    return SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: DesktopTextSelectionControls(),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Builder(
                              builder: (context) {
                                final imgLink = classList[index].innerImageLink;
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
                          ListTile(
                            title: Text(classList[index].content ?? "no val",),
                          ),
                        ],
                      ),
                    );
                    // return Image.network(getFeed.listImg[index]);
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
