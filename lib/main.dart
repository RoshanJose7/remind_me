import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/MainApp.dart';
import 'package:remind_me/pages/Onboarding.dart';
import 'package:remind_me/pages/Signup.dart';
import 'package:remind_me/pages/Subjects.dart';
import 'package:remind_me/providers/ClassesToday.dart';
import 'package:remind_me/providers/MainState.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:remind_me/providers/Theme.dart';
import 'package:remind_me/providers/calendar_provider.dart';
import 'package:remind_me/providers/subjects_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Themes>(create: (ctx) => Themes()),
        ChangeNotifierProvider<SubjectsProvider>(
            create: (ctx) => SubjectsProvider()),
        ChangeNotifierProvider<MainState>(create: (ctx) => MainState()),
        ChangeNotifierProxyProvider<SubjectsProvider, ClassesToday>(
          create: (ctx) => ClassesToday(null),
          update: (ctx, subjects, classesToday) => ClassesToday(subjects),
        ),
        ChangeNotifierProvider<CalendarProvider>(
            create: (ctx) => CalendarProvider()),
        ListenableProvider<Tasks>(create: (ctx) => Tasks()),
      ],
      child: Router(prefs),
    ),
  );
}

class Router extends StatelessWidget {
  SharedPreferences prefs;

  Router(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<Themes>(context);
    bool? hideIntro = prefs.getString('hideIntro') == null
        ? false
        : prefs.getString('hideIntro') == 'true'
            ? true
            : false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Product Sans",
        primaryColor: theme.theme.primaryColor,
        backgroundColor: theme.theme.backgroundColor,
        accentColor: theme.theme.selectedIconColor,
        unselectedWidgetColor: theme.theme.unselectedIconColor,
        cardColor: theme.theme.darkTextColor,
        shadowColor: theme.theme.mediumTextColor,
        appBarTheme: AppBarTheme(
          backgroundColor: theme.theme.backgroundColor,
        ),
      ),
      initialRoute: hideIntro == true ? "/" : "/onboard",
      routes: {
        "/": (context) => const AppPlaceholder(),
        "/getInfo": (context) => GetInfoPage(),
        "/onboard": (context) => UserOnboard(),
        "/allSubjects": (context) => AllSubjectsPage(),
      },
    );
  }
}
