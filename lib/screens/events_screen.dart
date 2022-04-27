import 'package:flutter/material.dart';
import '../components/event_tile.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url =
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg';

    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      children: <Widget>[
        EventTile(
          onTap: () {},
          logo: 'images/codeforces_logo.png',
          name: 'Codeforces',
        ),
        EventTile(
          onTap: () {},
          logo: 'images/hackerrank_logo.jpg',
          name: 'Hackerrank',
        ),
        EventTile(
          onTap: () {},
          logo: 'images/codechef_logo.jpg',
          name: 'Codechef',
        ),
        EventTile(
          onTap: () {},
          logo: 'images/kaggle_logo.png',
          name: 'Kaggle',
        ),
        EventTile(
          onTap: () {},
          logo: 'images/topcoder_logo.png',
          name: 'TopCoder',
        ),
        EventTile(
          onTap: () {},
          logo: 'images/hackerearth_logo.png',
          name: 'HackerEarth',
        ),
      ],
    );
  }
}
