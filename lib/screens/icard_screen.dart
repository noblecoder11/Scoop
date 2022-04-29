import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class IDCardScreen extends StatefulWidget {
  const IDCardScreen({Key? key}) : super(key: key);

  @override
  _IDCardScreenState createState() => _IDCardScreenState();
}

class _IDCardScreenState extends State<IDCardScreen>
    with AutomaticKeepAliveClientMixin {
  late final String url1;
  late final String url2;
  bool visible = true;
  @override
  bool get wantKeepAlive => true;

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    secureScreen();
    super.initState();
    getUrls();
  }

  void getUrls() async {
    var storage = FirebaseStorage.instance.ref('i-cards');
    final FirebaseAuth auth = FirebaseAuth.instance;
    String? phone = auth.currentUser?.phoneNumber;
    phone = phone?.substring(3);
    var urla =
        await storage.child('$phone').child('icard_front.jpg').getDownloadURL();
    var urlb =
        await storage.child('$phone').child('icard_back.jpg').getDownloadURL();
    setState(() {
      url1 = urla;
      url2 = urlb;
      visible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        : Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(url1),
                Image.network(url2),
              ],
            ),
          );
  }
}
