import 'package:flutter/material.dart';

class IDCardScreen extends StatelessWidget {
  const IDCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'images/idfront.png',
          ),
          Image.asset(
            'images/idrear.png',
          ),
        ],
      ),
    );
  }
}
