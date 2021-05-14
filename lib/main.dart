import 'package:flutter/material.dart';

import 'package:remind_me/MainApp.dart';
import 'package:remind_me/pages/AllSubjects.dart';
import 'package:remind_me/shared/globals.dart';
import 'package:remind_me/pages/Calender.dart';
import 'package:remind_me/pages/UserOnboard.dart';

void main() {
  CalenderPage.generateTodaysClasses();
  Global.generateDays();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Product Sans",
        accentColor: Color(0xFF37408A),
        backgroundColor: Color(0xFFD4E7FE),
      ),
      initialRoute: "/onboard",
      routes: {
        "/": (context) => MainApp(),
        "/onboard": (context) => UserOnboard(),
        "/allSubjects": (context) => AllSubjects(),
        // "/addSubject": (context) => AddSubject(),
      },
    ),
  );
}
