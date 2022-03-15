import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  const EventTile(
      {Key? key, required this.onTap, required this.logo, required this.name})
      : super(key: key);
  final void Function() onTap;
  final String logo;
  final String name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
