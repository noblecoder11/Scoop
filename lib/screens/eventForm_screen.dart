import 'package:flutter/material.dart';

class New_Event extends StatefulWidget {
  New_Event({Key? key}) : super(key: key);

  @override
  State<New_Event> createState() => _New_EventState();
}

class _New_EventState extends State<New_Event> {
  Color colour = const Color(0xFF7FCEE8);
  TextEditingController myController = TextEditingController();
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  TextEditingController myController3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 7),
              child: TextField(
                controller: myController,
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
                  hintText: 'Enter Event Name',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 7),
              child: TextField(
                controller: myController1,
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
                  hintText: 'Enter Start Time',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 7),
              child: TextField(
                controller: myController2,
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
                  hintText: 'Enter End Time',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 7),
              child: TextField(
                controller: myController3,
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
                  hintText: 'Enter Event URL',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              )),
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
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      'Add Events',
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
      )),
    );
  }
}
