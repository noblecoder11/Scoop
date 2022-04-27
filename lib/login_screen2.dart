import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:scoop/bottom_nav_bar.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.verifyId}) : super(key: key);
  final String verifyId;
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool visibility = false;

  void getClipboardData() async {
    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
    String? copiedText = cdata?.text;
    setState(() {
      otpController.setText(copiedText!);
    });
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
                child: Pinput(
                  length: 6,
                  readOnly: true,
                  controller: otpController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  onCompleted: (pin) async {
                    setState(() {
                      visibility = true;
                    });
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: widget.verifyId,
                      smsCode: pin,
                    );
                    await auth.signInWithCredential(credential).then(
                      (value) {
                        try {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BNavBar()));
                        } catch (err) {
                          AlertDialog();
                        }
                      },
                    );
                  },
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
                  onPressed: () async {
                    setState(() {
                      visibility = true;
                    });
                    getClipboardData();
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: widget.verifyId,
                      smsCode: otpController.text,
                    );
                    await auth.signInWithCredential(credential).then(
                      (value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BNavBar()));
                      },
                    );
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
}
