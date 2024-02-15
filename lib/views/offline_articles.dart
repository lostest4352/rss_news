import 'package:flutter/material.dart';
import 'package:that_app/views/appdrawer.dart';

class OfflineArticlesPage extends StatelessWidget {
  const OfflineArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Articles"),
      ),
      drawer: AppDrawer(),
      body: Column(),
    );
  }
}
