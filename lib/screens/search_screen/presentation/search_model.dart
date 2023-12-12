import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPageModel with ChangeNotifier {
  final unfocusNode = FocusNode();

  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
    super.dispose();
  }

  List<dynamic> data = [];
  List<dynamic> filteredEvents = [];

  Future<void> searchEvents(String query) async {
    final response = await http.get(Uri.parse(
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event?search=$query"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      data = jsonResponse['content']['data'];
      filteredEvents = List.from(data);
      notifyListeners();
    }
  }
}
