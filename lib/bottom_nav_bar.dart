import 'package:flutter/material.dart';
import 'screens/calendar_screen.dart';
import 'package:scoop/components/nav_bar_item.dart';
import 'screens/events_screen.dart';
import 'screens/icard_screen.dart';
import 'package:scoop/screens/library_screen.dart';
import 'package:scoop/screens/profile_screen.dart';

class BNavBar extends StatefulWidget {
  const BNavBar({Key? key}) : super(key: key);

  @override
  _BNavBarState createState() => _BNavBarState();
}

class _BNavBarState extends State<BNavBar> {
  int selectedPage = 2;
  final pages = [
    const Library(),
    const Events(),
    const IDCardScreen(),
    const Calendar(),
    const Profile(),
  ];
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: selectedPage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scoop',
        ),
        backgroundColor: const Color(0xFF7FCEE8),
      ),
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
      floatingActionButton: SizedBox(
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF7FCEE8),
            onPressed: () {
              setState(() {
                selectedPage = 2;
                _pageController.jumpToPage(2);
              });
            },
            child: Icon(
              Icons.badge_outlined,
              size: 35,
              color: selectedPage == 2
                  ? Colors.black
                  : Colors.black.withOpacity(0.6),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFF3EDF7),
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NavBarItem(
                colour: selectedPage == 0
                    ? Colors.black
                    : Colors.black.withOpacity(0.6),
                bgcolour: selectedPage == 0
                    ? const Color(0xFFE8DEF8)
                    : Colors.transparent,
                label: 'Library',
                icon: const Icon(Icons.local_library),
                onPressed: () {
                  setState(() {
                    selectedPage = 0;
                    _pageController.jumpToPage(0);
                  });
                },
              ),
              NavBarItem(
                colour: selectedPage == 1
                    ? Colors.black
                    : Colors.black.withOpacity(0.6),
                bgcolour: selectedPage == 1
                    ? const Color(0xFFE8DEF8)
                    : Colors.transparent,
                label: 'Events',
                icon: const Icon(Icons.alarm_on_outlined),
                onPressed: () {
                  setState(() {
                    selectedPage = 1;
                    _pageController.jumpToPage(1);
                  });
                },
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPage = 2;
                    _pageController.jumpToPage(2);
                  });
                },
                child: SizedBox(
                  width: 50,
                  height: 55,
                  child: Align(
                    child: Text(
                      'ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedPage == 2
                            ? Colors.black
                            : Colors.black.withOpacity(0.6),
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
              NavBarItem(
                colour: selectedPage == 3
                    ? Colors.black
                    : Colors.black.withOpacity(0.6),
                bgcolour: selectedPage == 3
                    ? const Color(0xFFE8DEF8)
                    : Colors.transparent,
                label: 'Calendar',
                icon: const Icon(Icons.event_outlined),
                onPressed: () {
                  setState(() {
                    selectedPage = 3;
                    _pageController.jumpToPage(3);
                  });
                },
              ),
              NavBarItem(
                colour: selectedPage == 4
                    ? Colors.black
                    : Colors.black.withOpacity(0.6),
                bgcolour: selectedPage == 4
                    ? const Color(0xFFE8DEF8)
                    : Colors.transparent,
                label: 'Profile',
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  setState(() {
                    selectedPage = 4;
                    _pageController.jumpToPage(4);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
