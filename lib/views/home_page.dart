import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/notifiers/get_feed.dart';
import 'package:that_app/views/widgets/appdrawer.dart';
import 'package:that_app/views/news_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      drawer: const AppDrawer(),
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
                            siteTitle: "News Of Nepal",
                          );
                        },
                      ),
                    );
                  },
                  title: const Text("News Of Nepal"),
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
                      "https://rss.nytimes.com/services/xml/rss/nyt/Science.xml",
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewsListPage(
                            siteTitle: "NYTimes Science",
                          );
                        },
                      ),
                    );
                  },
                  title: const Text("NYTimes Science"),
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
