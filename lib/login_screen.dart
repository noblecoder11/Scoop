import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoop/login_screen2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController myController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore inst = FirebaseFirestore.instance;
  String message = '';
  Color colour = const Color(0xFF7FCEE8);
  bool visibility = false;

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
                      const Color(0xFF7FCEE8),
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
                          .then(
                        (DocumentSnapshot document) {
                          if (!document.exists) {
                            setState(() {
                              message =
                                  'This number is not a part of PICT Org.';
                            });
                          } else {
                            setState(
                              () {
                                colour = const Color(0xFF7FCEE8);
                                message = '';
                                visibility = true;
                                verifyPhoneNumber(myController.text);
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Get OTP',
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
              Visibility(
                visible: visibility,
                child: const SpinKitFadingCircle(
                  color: Color(0xFF7FCEE8),
                  size: 50.0,
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
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException exception) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              verifyId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationID) {},
      timeout: const Duration(seconds: 0),
    );
  }
}
