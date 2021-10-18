import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/MainApp.dart';
import 'package:remind_me/pages/AddSubject.dart';
import 'package:remind_me/pages/AllSubjects.dart';
import 'package:remind_me/pages/GetInfoPage.dart';
import 'package:remind_me/pages/UserOnboard.dart';
import 'package:remind_me/providers/ClassesToday.dart';
import 'package:remind_me/providers/MainState.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:remind_me/providers/Theme.dart';
import 'package:remind_me/shared/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Global.generateDays();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MainState>(create: (ctx) => MainState()),
        ChangeNotifierProvider<Subjects>(create: (ctx) => Subjects()),
        ChangeNotifierProvider<Themes>(create: (ctx) => Themes()),
        ChangeNotifierProxyProvider<Subjects, ClassesToday>(
          create: (ctx) => ClassesToday(null),
          update: (ctx, subjects, classesToday) => ClassesToday(subjects),
        ),
        ListenableProvider<Tasks>(create: (ctx) => Tasks()),
      ],
      child: MyApp(prefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  SharedPreferences prefs;
  MyApp(this.prefs);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<Themes>(context);
    print(_theme.theme);
    bool? hideIntro = prefs.getString('hideIntro') == null
        ? false
        : prefs.getString('hideIntro') == 'true'
            ? true
            : false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Product Sans",
        primaryColor: _theme.theme,
        backgroundColor: Color(0xFFD4E7FE),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF0F0F0),
          actionsIconTheme: IconThemeData(color: Colors.blueGrey),
        ),
      ),
      initialRoute: hideIntro == true ? "/" : "/onboard",
      routes: {
        "/": (context) => MainApp(),
        "/getInfo": (context) => GetInfoPage(),
        "/onboard": (context) => UserOnboard(),
        "/allSubjects": (context) => AllSubjects(),
        "/addSubject": (context) => AddSubject(),
      },
    );
  }
}
