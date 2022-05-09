import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scoop/constants/kcalendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventDetailsTile extends StatelessWidget {
  EventDetailsTile(
      {Key? key,
      required this.startTime,
      required this.endTime,
      required this.title,
      required this.link})
      : super(key: key);
  final DateTime startTime;
  final DateTime endTime;
  final String title;
  final String link;

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This event was added to the calendar!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchInBrowser() async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore inst = FirebaseFirestore.instance;

  late Map<String, dynamic> data;
  late DocumentReference<Map<String, dynamic>> docs;

  String? getPhone() {
    String? phone = auth.currentUser?.phoneNumber?.substring(3);
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            // leading: Icon(Icons.arrow_drop_down_circle),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            subtitle: Text(
              "Start: " +
                  startTime.toString().substring(0, 16) +
                  "\nEnd:   " +
                  endTime.toString().substring(0, 16),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Color(0xFF7FCEE8))),
                onPressed: _launchInBrowser,
                child: const Text('OPEN'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Color(0xFF7FCEE8))),
                onPressed: () {
                  if (calendarMap[startTime] != null) {
                    calendarMap[startTime] = [
                      Event(
                          name: title,
                          start_time: startTime.toString(),
                          end_time: endTime.toString(),
                          link: link)
                    ];
                    // calendarMap.(startTime: Event(name: title, start_time: startTime.toString(), end_time: endTime.toString(), link: link));
                  } else {
                    calendarMap[startTime]?.add(Event(
                        name: title,
                        start_time: startTime.toString().substring(0, 16),
                        end_time: endTime.toString().substring(0, 16),
                        link: link));
                  }

                  var date = startTime.toString().substring(0, 10);
                  inst.collection('Username').doc(getPhone()).update({
                    'MyEvents.$date.${title.replaceAll('.', '%2E')}': {
                      'start_time': startTime.toString(),
                      'end_time': endTime.toString(),
                      'link': link
                    }
                  });

                  _showMyDialog(context);
                },
                child: const Text('ADD TO CALENDAR'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
