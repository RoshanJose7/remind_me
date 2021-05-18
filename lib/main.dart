import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:remind_me/MainApp.dart';
import 'package:remind_me/pages/AddSubject.dart';
import 'package:remind_me/pages/AllSubjects.dart';
import 'package:remind_me/providers/ClassesToday.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:remind_me/shared/globals.dart';
import 'package:remind_me/pages/UserOnboard.dart';

void main() {
  Global.generateDays();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Subjects>(create: (ctx) => Subjects()),
        ChangeNotifierProxyProvider<Subjects, ClassesToday>(
          create: (ctx) => ClassesToday(null),
          update: (ctx, subjects, classesToday) => ClassesToday(subjects),
        ),
        ListenableProvider<Tasks>(create: (ctx) => Tasks()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Product Sans",
          accentColor: Color(0xFF37408A),
          backgroundColor: Color(0xFFD4E7FE),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFF0F0F0),
            actionsIconTheme: IconThemeData(color: Colors.blueGrey),
          ),
        ),
        initialRoute: "/onboard",
        routes: {
          "/": (context) => MainApp(),
          "/onboard": (context) => UserOnboard(),
          "/allSubjects": (context) => AllSubjects(),
          "/addSubject": (context) => AddSubject(),
        },
      ),
    ),
  );
}
