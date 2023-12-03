import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EventCards extends StatefulWidget {
  const EventCards({Key? key});

  @override
  State<EventCards> createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> {
  List<dynamic> data = [];

  void getEventList() async {
    final response = await http.get(Uri.parse(
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(response.body);
      setState(() {
        data = jsonResponse['content']['data'];
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
    if (data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
          child: Material(
            color: Colors.transparent,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
                onTap: (){
                Navigator.pushNamed(context,'/eventDetails',
                arguments: data[index]['id']);
                },
              child: Container(
                height: MediaQuery.of(context).devicePixelRatio * 65,
                width: MediaQuery.of(context).devicePixelRatio * 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
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
                      child:CachedNetworkImage(
                        imageUrl:data[index]['organiser_icon'],
                        width: 142,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 5),
                            child: Text(
                              DateFormat('yyyy-MM-dd').format(DateTime.parse(data[index]['date_time'])),
                              style:TextStyle(
                                  fontSize:15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.lightBlueAccent
                              ),
                            ),
                          ),
                          Text(
                              data[index]['title'] ?? '',
                          style:const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          Padding(
                            padding:  EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Icon(
                                  Icons.place,
                                  size: 14,
                                ),
                                Text(
                                  data[index]['venue_name'] +" \n "+ data[index]['venue_city'],
                                style:TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color:Colors.grey
                                ),
                                ),
                              ]
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
