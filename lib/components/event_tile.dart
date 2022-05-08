import 'package:flutter/material.dart';
import '../screens/eventDetails_screen.dart';

class EventTile extends StatelessWidget {
  const EventTile({Key? key, required this.logo, required this.name})
      : super(key: key);
  final String logo;
  final String name;

  @override
  Widget build(BuildContext context) {
    void pushScreen() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetails(
                    name: name,
                  )));
    }

    return GestureDetector(
      onTap: pushScreen,
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(logo),
              ),
              title: Text(
                name,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
