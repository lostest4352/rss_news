import 'package:flutter/material.dart';
import 'package:that_app/views/home_page.dart';
import 'package:that_app/views/offline_articles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ),
              );
            },
            title: const Text("Home Page"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const OfflineArticlesPage();
                  },
                ),
              );
            },
            title: const Text("Saved Articles"),
          ),
        ],
      ),
    );
  }
}
