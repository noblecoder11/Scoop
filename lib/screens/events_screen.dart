import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../components/event_tile.dart';

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
<<<<<<< HEAD
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
=======
    var url =
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg';

    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      children: <Widget>[
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
          logo: 'images/hackerearth_logo.png',
          name: 'HackerEarth',
        ),
      ],
    );
>>>>>>> 9e9dce5d367b2932789af0b5a21271df443998d7
  }
}
