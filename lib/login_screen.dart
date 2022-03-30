import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
//import 'bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:sms_receiver/sms_receiver.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SmsReceiver? _smsReceiver;
  TextEditingController myController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore inst = FirebaseFirestore.instance;
  String message = '';
  Color colour = const Color(0xFF7FCEE8);
  String? otp;

  @override
  void initState() {
    super.initState();
    _smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
    _startListening();
  }

  void onSmsReceived(String? message) {
    setState(() {
      otp = message;
      print(otp);
    });
    // _stopListening();
  }

  void onTimeout() {
    setState(() {
      print("Timed out");
    });
  }

  void _startListening() async {
    if (_smsReceiver == null) return;
    await _smsReceiver?.startListening();
    setState(() {});
  }

  void _stopListening() async {
    if (_smsReceiver == null) return;
    await _smsReceiver?.stopListening();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 70.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/logo.png',
                      width: 70.0,
                    ),
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Scoop',
                          speed: const Duration(
                            milliseconds: 80,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 40.0,
                            color: Color(0xFF7FCEE8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 7),
                child: TextField(
                  controller: myController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 30.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colour,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colour,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Enter registered phone number',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 35.0,
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  15.0,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF7FCEE8),
                    ),
                  ),
                  onPressed: () {
                    if (myController.text.isEmpty) {
                      setState(() {
                        message = 'Can\'t be empty';
                        colour = Colors.red;
                      });
                    } else if (myController.text.length != 10) {
                      setState(() {
                        message = 'Invalid mobile length';
                        colour = Colors.red;
                      });
                    } else {
                      inst
                          .collection('Username')
                          .doc(myController.text)
                          .get()
                          .then((DocumentSnapshot document) {
                        if (!document.exists) {
                          setState(() {
                            message = 'This number is not a part of PICT Org.';
                          });
                        } else {
                          setState(() {
                            colour = const Color(0xFF7FCEE8);
                            message = '';
                            verifyPhoneNumber(myController.text);

                            //TODO: Add further login functionality
                          });
                        }
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyPhoneNumber(String phone) {
    auth.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential user = await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException exception) {
          // print(exception.message);
          print("custom exception");
        },
        codeSent: (String verificationId, int? resendToken) {
          print("code sent");
          _startListening();
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          print("timed out");
        });
  }
}
