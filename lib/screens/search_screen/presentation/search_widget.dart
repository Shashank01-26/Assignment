import 'dart:async';

import 'package:events/widgets/card_view_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:events/screens/search_screen/presentation/search_model.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = SearchPageModel();

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _performSearch(String query) {
    _model.searchEvents(query);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                iconSize: 20,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: Text(
                  "Search...",
                  style: TextStyle(
                      color:
                          Color.fromARGB(255, 0, 0, 0)), // Add text style here
                ),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        width: 1.0, color: Color.fromARGB(95, 171, 171, 171)),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 0, 8, 0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: true,
                              onChanged: (query) => _performSearch(query),
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: "Search...",
                                labelStyle: TextStyle(
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  color: Color.fromARGB(255, 186, 186, 186),
                                ),
                                hintStyle: TextStyle(
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: GoogleFonts.openSans().fontFamily,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ChangeNotifierProvider<SearchPageModel>.value(
                value: _model,
                builder: (context, child) {
                  return Consumer<SearchPageModel>(
                    builder: (context, value, child) {
                      return Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: EventCards(
                            events: value.filteredEvents,
                            key: ValueKey(value.filteredEvents.hashCode),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
