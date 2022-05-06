import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scoop/constants/links.dart';

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

  Future<void> _launchInBrowser() async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  _launchURL() async {
    Uri url = Uri.parse('https://flutter.dev');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // final Uri _url = Uri.parse('https://google.com');

  // void _launchUrl() async {
  //   if (!await launchUrl(_url)) throw 'Could not launch $_url';
  // }

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
                    textStyle: TextStyle(color: const Color(0xFF7FCEE8))),
                onPressed: _launchInBrowser,
                child: const Text('OPEN'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(color: const Color(0xFF7FCEE8))),
                onPressed: () {
                  print('Added to calendar');
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
