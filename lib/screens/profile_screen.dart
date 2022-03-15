import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 50.0,
                    ),
                    ListTile(
                      // leading: Icon(Icons.arrow_drop_down_circle),
                      title: const Center(
                          child: Text(
                        'Student Name',
                        style: TextStyle(fontSize: 21.0),
                      )),
                      subtitle: Center(
                        child: Text(
                          'C2K20100000',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
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
            onPressed: () {},
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
