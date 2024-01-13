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
              IconButton(
                onPressed: () {
                  getFeed.getData();
                },
                icon: const Icon(Icons.add),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: getFeed.newsClassList.length,
                  itemBuilder: (context, index) {
                    final classList = getFeed.newsClassList;
                    return Column(
                      children: [
                        ListTile(
                          title: SelectableText(classList[index].title),
                          subtitle: () {
                            if (classList[index].description != null) {
                              return SelectableText(
                                  classList[index].description!);
                            }
                          }(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Builder(
                            builder: (context) {
                              final imgLink = classList[index].innerImageLink;
                              if (imgLink != null) {
                                return CachedNetworkImage(
                                  imageUrl: classList[index].innerImageLink!,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error);
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Icon(Icons.error),
                                );
                              }
                            },
                          ),
                        ),

                        // () {
                        //   if (index < getFeed.listImg.length) {
                        //     return CachedNetworkImage(
                        //       imageUrl: getFeed.listImg[index],
                        //       placeholder: (context, url) =>
                        //           const CircularProgressIndicator(),
                        //       errorWidget: (context, url, error) {
                        //         return const Icon(Icons.error);
                        //       },
                        //     );
                        //     // return Image.network(getFeed.listImg[index]);
                        //   } else {
                        //     return const Center();
                        //   }
                        // }(),
                      ],
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
