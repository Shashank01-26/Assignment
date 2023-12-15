import 'package:cached_network_image/cached_network_image.dart';
import 'package:events/widgets/card_animations.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EventCards extends StatefulWidget {
  final List<dynamic> events;

  const EventCards({Key? key, required this.events}) : super(key: key);

  @override
  State<EventCards> createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> {
  late List<dynamic> data = widget.events;

  void getEventList() async {
    final response = await http.get(Uri.parse(
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      setState(() {
        data = jsonResponse['content']['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (data.isEmpty) getEventList();
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: data.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemBuilder: (BuildContext context, int index) {
        if (index < 5) {
          return _itemBuilder(index).myanimate(delay: 150 * index);
        }
        return _itemBuilder(index);
      },
    );
  }

  Widget _itemBuilder(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/eventDetails',
              arguments: data[index]['id']);
        },
        child: Container(
          height: MediaQuery.of(context).devicePixelRatio * 65,
          width: MediaQuery.of(context).devicePixelRatio * 50,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.grey.shade300),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: CachedNetworkImage(
                  imageUrl: data[index]['organiser_icon'],
                  width: 142,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(data[index]['date_time'])),
                        style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.lightBlueAccent),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        data[index]['title'] ?? '',
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.translate(
                                offset: const Offset(-5, 0),
                                child: const Icon(
                                  Icons.place,
                                  size: 16,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data[index]['venue_name'] +
                                      ",\n" +
                                      data[index]['venue_city'],
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
