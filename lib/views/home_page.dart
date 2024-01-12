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
                  itemCount: getFeed.listVal.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: SelectableText(getFeed.listVal[index]),
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
