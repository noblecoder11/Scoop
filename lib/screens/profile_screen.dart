import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoop/login_screen.dart';
import 'eventForm_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final String url1;
  late Map<String, dynamic> data;
  late DocumentSnapshot<Map<String, dynamic>> docs;
  bool visible = true;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore inst = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getFutureDocData();
    getUrls();
  }

  void getFutureDocData() async {
    var documents = await inst.collection('Username').doc(getPhone()).get();
    setState(() {
      docs = documents;
    });
    if (docs.exists) {
      setState(() {
        data = docs.data()!;
      });
    }
  }

  void getUrls() async {
    var storage = FirebaseStorage.instance.ref('i-cards');
    final FirebaseAuth auth = FirebaseAuth.instance;
    String? phone = auth.currentUser?.phoneNumber;
    phone = phone?.substring(3);
    var urla =
        await storage.child('$phone').child('profile.jpg').getDownloadURL();
    setState(() {
      url1 = urla;
      visible = false;
    });
  }

  String? getPhone() {
    String? phone = auth.currentUser?.phoneNumber?.substring(3);
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return visible
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SpinKitFadingCircle(
                color: Color(0xFF7FCEE8),
                size: 80.0,
              )
            ],
          )
        : Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(url1),
                            backgroundColor: Colors.grey,
                            radius: 50.0,
                          ),
                          ListTile(
                            // leading: Icon(Icons.arrow_drop_down_circle),
                            title: Center(
                                child: Text(
                              data['Name'],
                              style: const TextStyle(fontSize: 21.0),
                            )),
                            subtitle: Center(
                              child: Text(
                                data['mis'],
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 2.0,
                ),
                TextButton(
                  onPressed: () {},
                  child: const ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    title: Text(
                      'MANAGE INTERESTS',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 2.0,
                ),
                TextButton(
                  onPressed: () {
                    // auth.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => New_Event()));
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    title: Text(
                      'ADD New Event',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 1.5,
                  height: 0,
                ),
                TextButton(
                  onPressed: () {
                    auth.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    title: Text(
                      'LOGOUT',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 1.5,
                  height: 0,
                ),
              ],
            ),
          );
  }
}
