import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remind_me/pages/AttendencePercentage.dart';
import 'package:remind_me/pages/Calender.dart';
import 'package:remind_me/pages/Home.dart';
import 'package:remind_me/pages/Settings.dart';
import 'package:remind_me/pages/Subjects.dart';
import 'package:remind_me/pages/Tasks.dart';

class AppPlaceholder extends StatefulWidget {
  const AppPlaceholder({super.key});

  @override
  _AppPlaceholderState createState() => _AppPlaceholderState();
}

class _AppPlaceholderState extends State<AppPlaceholder> {
  DateTime? _lastPressedAt;
  int _selectedItemIndex = 0;

  void pushToAllSubjectsPage() {
    setState(() {
      _selectedItemIndex = 1;
    });
  }

  void pushToTasksPage() {
    setState(() {
      _selectedItemIndex = 3;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List pages = [
      HomePage(
        pushToTasksPage: pushToTasksPage,
        pushToSubjectsPage: pushToAllSubjectsPage,
      ),
      const AllSubjectsPage(),
      const AttendancePercentagePage(),
      const TasksPage(),
      const CalenderPage(),
      ProfilePage(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            (DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 1))) {
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
          backgroundColor: const Color(0xFFF0F0F0),
          unselectedItemColor: theme.unselectedWidgetColor,
          selectedItemColor: theme.accentColor,
          selectedIconTheme: IconThemeData(color: theme.accentColor),
          currentIndex: _selectedItemIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _selectedItemIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Subjects",
              icon: Icon(Icons.book_rounded),
            ),
            BottomNavigationBarItem(
              label: "Attendance",
              icon: FaIcon(
                FontAwesomeIcons.percentage,
                size: 25,
              ),
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
          child: pages[_selectedItemIndex],
        ),
      ),
    );
  }
}
