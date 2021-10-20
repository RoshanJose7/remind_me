import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme {
  final Color primaryColor;
  final Color backgroundColor;
  final Color darkTextColor;
  final Color mediumTextColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;

  CustomTheme({
    required this.primaryColor,
    required this.backgroundColor,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    required this.darkTextColor,
    required this.mediumTextColor,
  });
}

class Themes with ChangeNotifier {
  int _themeIdx = 0;
  List<CustomTheme> _themes = [
    CustomTheme(
      primaryColor: Color(0xFF2979FF),
      backgroundColor: Color(0xFF9DC8FF),
      selectedIconColor: Color(0xFF2979FF),
      unselectedIconColor: Color(0xFF9DC8FF),
      darkTextColor: Color(0xFF0047C1),
      mediumTextColor: Color(0xFF0030A4),
    ),
    CustomTheme(
      primaryColor: Color(0xFFD6503D),
      backgroundColor: Color(0xFFFF9F84),
      selectedIconColor: Color(0xFFC33F2F),
      unselectedIconColor: Color(0xFFFF9F84),
      darkTextColor: Color(0xFF860001),
      mediumTextColor: Color(0xFFAD2B20),
    ),
    CustomTheme(
      primaryColor: Color(0xFF00E676),
      backgroundColor: Color(0xFF00E071),
      selectedIconColor: Color(0xFF008B23),
      unselectedIconColor: Color(0xFF00E373),
      darkTextColor: Color(0xFF008B23),
      mediumTextColor: Color(0xFF006000),
    ),
    CustomTheme(
      primaryColor: Color(0xFF9C27B0),
      backgroundColor: Color(0xFFFF8EFF),
      selectedIconColor: Color(0xFFBE4BD1),
      unselectedIconColor: Color(0xFFFF8EFF),
      darkTextColor: Color(0xFF85019A),
      mediumTextColor: Color(0xFF6A1B9A),
    ),
  ];

  Themes() {
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString('themeIdx');

    if (encodedData != null) {
      _themeIdx = int.parse(encodedData);
      notifyListeners();
    }
  }

  CustomTheme get theme {
    return _themes[_themeIdx];
  }

  int get themeIdx {
    return _themeIdx;
  }

  List<Color> get colorThemes {
    List<Color> temp = [];

    _themes.forEach((element) {
      temp.add(element.primaryColor);
    });

    return temp;
  }

  void storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeIdx', _themeIdx.toString());
  }

  void changeTheme({required int idx}) {
    _themeIdx = idx;
    notifyListeners();
    storeData();
  }
}
