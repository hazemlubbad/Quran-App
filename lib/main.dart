import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/servises/provider.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) =>
            BookmarkProvider()..createTable(context),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
        )),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: LoadingScreen(),
        ));
  }
}
