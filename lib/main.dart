import 'package:provider/provider.dart';
import 'package:that_app/database/database.dart';
import 'package:that_app/notifiers/get_feed.dart';
import 'package:that_app/views/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ),
        Provider<AppDatabase>(
          create: (context) {
            return AppDatabase();
          },
        ),
        StreamProvider<List<SavedArticle>?>(
          create: (context) {
            return context.read<AppDatabase>().getDataStream();
          },
          initialData: null,
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const HomePage(),
        );
      },
    );
  }
}
