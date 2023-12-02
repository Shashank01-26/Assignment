import 'package:events/screens/home_screen/presentation/home_screen_widget.dart';
import 'package:events/screens/search_screen/presentation/search_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(   
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Colors.transparent,
              elevation:0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
      ),   
      home: HomeScreen(),
      routes:{
        '/searchPage' : (context) => const SearchPage(),
      }
    );
  }
}

