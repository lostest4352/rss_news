import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:that_app/services/get_feed.dart';
import 'package:that_app/views/news_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
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
                    value.getData('https://www.onlinekhabar.com/feed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewsPage();
                        },
                      ),
                    );
                  },
                  title: const Text("Online Khabar"),
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
                          return const NewsPage();
                        },
                      ),
                    );
                  },
                  title: const Text("New York Times"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
