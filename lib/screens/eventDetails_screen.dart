import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoop/components/event_details_tile.dart';
import 'package:http/http.dart' as http;
import 'package:scoop/constants/links.dart';

class EventDetails extends StatefulWidget {
  EventDetails({Key? key, required String this.name}) : super(key: key);
  String name;

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool visible = false;
  List<Widget> events = [];

  String API_URL = API_URL_Kickstart;

  void setApiUrl() {
    switch (widget.name) {
      case 'Codechef':
        API_URL = API_URL_Codechef;
        break;
      case 'Codeforces':
        API_URL = API_URL_Codeforces;
        break;
      case 'AtCoder':
        API_URL = API_URL_AtCoder;
        break;
      case 'TopCoder':
        API_URL = API_URL_TopCoder;
        break;
      case 'Hackerrank':
        API_URL = API_URL_Hackerrank;
        break;
      case 'HackerEarth':
        API_URL = API_URL_Hackerearth;
        break;
      case 'Kickstart':
        API_URL = API_URL_Kickstart;
        break;
      case 'Leetcode':
        API_URL = API_URL_Leetcode;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  void fetchAlbum() async {
    setApiUrl();
    final response = await http.get(Uri.parse(API_URL));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      setState(() {
        var contestList = jsonDecode(response.body);

        for (int i = 0; i < contestList.length; i++) {
          if (contestList[i]["name"] == 'Codechef') {
            String start = contestList[i]["start_time"];
            print(start);
          }
          events.add(EventDetailsTile(
            title: contestList[i]["name"],
            startTime: DateTime.parse(contestList[i]["start_time"]).toLocal(),
            endTime: DateTime.parse(contestList[i]["end_time"]).toLocal(),
            link: contestList[i]["url"],
          ));
        }
        visible = true;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          backgroundColor: const Color(0xFF7FCEE8),
        ),
        body: visible
            ? ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                children: events,
              )
            : const SpinKitFadingCircle(
                color: Color(0xFF7FCEE8),
                size: 80.0,
              ));
  }
}
