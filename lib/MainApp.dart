import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'package:remind_me/pages/Home.dart';
import 'package:remind_me/pages/Calender.dart';
import 'package:remind_me/pages/ProfilePage.dart';
import 'package:remind_me/pages/AllSubjects.dart';
import 'package:remind_me/pages/Assignments.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List _pages = [
    HomePage(),
    AllSubjects(),
    AssignmentsPage(),
    CalenderPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Color(0xFFF0F0F0),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
        currentIndex: _selectedItemIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _selectedItemIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Subjects",
            icon: Icon(Icons.book_rounded),
          ),
          BottomNavigationBarItem(
            label: "Tasks",
            icon: Icon(Icons.done),
          ),
          BottomNavigationBarItem(
            label: "Calender",
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_box_rounded),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        child: _pages[_selectedItemIndex],
      ),
    );
  }
}
