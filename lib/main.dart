import 'package:db_minor/provider/favourite_provider.dart';
import 'package:db_minor/provider/theme_provider.dart';
import 'package:db_minor/views/Quote_detail_page.dart';
import 'package:db_minor/views/detailpage.dart';
import 'package:db_minor/views/favourite.dart';
import 'package:db_minor/views/homepage.dart';
import 'package:db_minor/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FavouriteProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: (Provider.of<ThemeProvider>(context).istapped)
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => splashScreen(),
        'home': (context) => Homepage(),
        'detail': (context) => DetailPage(),
        'quote_detail': (context) => Quotedetailpage(),
        'fav': (context) => Favourite(),
      },
    );
  }
}
