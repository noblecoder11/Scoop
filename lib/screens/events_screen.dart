import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../components/event_tile.dart';
import 'eventDetails_screen.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore inst = FirebaseFirestore.instance;

  late Map<String, dynamic> data;
  late DocumentSnapshot<Map<String, dynamic>> docs;
  bool visible = false;

  List<Widget> events = [
    EventTile(
      onTap: () {},
      logo: 'images/codeforces_logo.png',
      name: 'Codeforces',
    ),
    EventTile(
      onTap: () {},
      logo: 'images/hackerrank_logo.jpg',
      name: 'Hackerrank',
    ),
    EventTile(
      onTap: () {},
      logo: 'images/codechef_logo.jpg',
      name: 'Codechef',
    ),
    EventTile(
      onTap: () {},
      logo: 'images/kaggle_logo.png',
      name: 'Kaggle',
    ),
    EventTile(
      onTap: () {},
      logo: 'images/topcoder_logo.png',
      name: 'TopCoder',
    ),
    EventTile(
      onTap: () {},
      logo: 'images/atcoder_logo.png',
      name: 'AtCoder',
    ),
    EventTile(
      onTap: () {},
      logo: 'images/leetcode_logo.png',
      name: 'Leetcode',
    ),
    EventTile(
      onTap: () {},
      logo: 'images/kickstart_logo.jpg',
      name: 'Kickstart',
    ),
    EventTile(
      onTap: () {},
      logo: 'images/hackerearth_logo.png',
      name: 'HackerEarth',
    ),
    const SizedBox(
      height: 20,
    ),
    const Divider(
      indent: 10.0,
      endIndent: 10.0,
      thickness: 3.0,
    ),
    const SizedBox(
      height: 20,
    ),
  ];

  @override
  void initState() {
    super.initState();
    getFutureDocData();
  }

  void getFutureDocData() async {
    var documents = await inst.collection('Username').doc(getPhone()).get();
    docs = documents;
    if (docs.exists) {
      setState(() {
        data = docs.data()!;
        for (var i in data['Clubs']) {
          events.add(
            EventTile(
              onTap: () {},
              logo: 'images/${i}_logo.png',
              name: '$i',
            ),
          );
        }
        visible = true;
      });
    }
  }

  String? getPhone() {
    String? phone = auth.currentUser?.phoneNumber?.substring(3);
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return visible
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
          );
  }
}
