import 'package:flutter/material.dart';

class EventCards extends StatefulWidget {
  const EventCards({super.key});

  @override
  State<EventCards> createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> {
  @override
  Widget build(BuildContext context) {    
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 5, 8, 0),
      child: Container(
        height: MediaQuery.devicePixelRatioOf(context) * 70,
        width: MediaQuery.devicePixelRatioOf(context) * 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 244, 244, 244),
              Color.fromARGB(255, 244, 244, 244),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Text(
          "Hello world",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

//Need to replace this Text widget with the List tile widget and add details