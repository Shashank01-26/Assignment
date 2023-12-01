import 'package:events/widgets/card_view_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Events",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color:Colors.black,
          ),
          ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search)
            ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.more_vert)
            ),
        ],
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index){
        return const EventCards();
      })
    );
  }
}
