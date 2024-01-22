import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/services/get_feed.dart';
import 'package:that_app/views/news_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Column(
                children: [
                  Spacer(),
                  Text("News App"),
                  Spacer(),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Home Page"),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Saved articles"),
            ),
          ],
        ),
      ),
      body: Consumer<GetFeed>(
        builder: (context, value, child) {
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    value.getData(
                      "https://nagariknews.nagariknetwork.com/feed",
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewsListPage(
                            siteTitle: "Nagarik News",
                          );
                        },
                      ),
                    );
                  },
                  title: const Text("Nagarik News"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    value.getData('https://www.onlinekhabar.com/feed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewsListPage(
                            siteTitle: "Online Khabar",
                          );
                        },
                      ),
                    );
                  },
                  title: const Text("Online Khabar"),
                ),

                //
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    value.getData(
                      "https://www.newsofnepal.com/feed/",
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewsListPage(
                            siteTitle: "Nepal Samacharpatra",
                          );
                        },
                      ),
                    );
                  },
                  title: const Text("Nepal Samacharpatra"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    value.getData(
                      "https://rajdhanidaily.com/feed/",
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewsListPage(
                            siteTitle: "Rajdhani Daily",
                          );
                        },
                      ),
                    );
                  },
                  title: const Text("Rajdhani Daily"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    value.getData(
                      "https://rss.nytimes.com/services/xml/rss/nyt/World.xml",
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewsListPage(
                            siteTitle: "New York Times",
                          );
                        },
                      ),
                    );
                  },
                  title: const Text("New York Times"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    value.getData(
                      "https://www.osnepal.com/feed",
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewsListPage(
                            siteTitle: "OsNepal",
                          );
                        },
                      ),
                    );
                  },
                  title: const Text("OsNepal"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
