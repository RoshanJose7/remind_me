import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animations/animations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:remind_me/pages/Home.dart';
import 'package:remind_me/pages/Calender.dart';
import 'package:remind_me/pages/ProfilePage.dart';
import 'package:remind_me/pages/AllSubjects.dart';
import 'package:remind_me/pages/Tasks.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  DateTime? _lastPressedAt;
  int _selectedItemIndex = 0;

  void pushToAllSubjectsPage() {
    setState(() {
      _selectedItemIndex = 1;
    });
  }

  void pushToTasksPage() {
    setState(() {
      _selectedItemIndex = 2;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List _pages = [
      HomePage(
        pushToTasksPage: pushToTasksPage,
      ),
      AllSubjects(),
      TasksPage(),
      CalenderPage(),
      ProfilePage(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            (DateTime.now().difference(_lastPressedAt!) >
                Duration(seconds: 1))) {
          Fluttertoast.showToast(
            fontSize: 12.0,
            msg: "Press again to exit the program",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            textColor: Colors.black87,
            gravity: ToastGravity.CENTER,
          );

          _lastPressedAt = DateTime.now();
          return false;
        }

        return true;
      },
      child: Scaffold(
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
      ),
    );
  }
}
