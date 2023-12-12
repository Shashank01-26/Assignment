import 'dart:convert';
import 'package:events/widgets/card_view_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:events/screens/event_details_screen/event_details_widget.dart';
import 'package:events/screens/home_screen/presentation/home_screen_widget.dart';
import 'package:events/screens/search_screen/presentation/search_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> data = [];
  void getEventList() async {
    final response = await http.get(Uri.parse(
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(response.body);
      setState(() {
        final List<dynamic> eventID = jsonResponse['content']['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEventList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: HomeScreen(),
        routes: {
          '/searchPage': (context) => const SearchPage(),
          '/eventDetails': (context) => Builder(
                builder: (context) {
                  final data =
                      ModalRoute.of(context)?.settings.arguments as int;

                  return EventDetailsWidget(data: data);
                },
              ),
        });
  }
}
