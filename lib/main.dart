import 'package:provider/provider.dart';
import 'package:that_app/services/get_feed.dart';
import 'package:that_app/views/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetFeed>(
          create: (context) {
            return GetFeed();
          },
        )
      ],
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const HomePage(),
        );
      },
    );
  }
}
