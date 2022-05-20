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
      primaryColor: Color(0xFF7FB5FF),
      backgroundColor: Color(0xFFa7cced),
      selectedIconColor: Color(0xFF545e75),
      unselectedIconColor: Color(0xFFa7cced),
      darkTextColor: Color(0xFF304d6d),
      mediumTextColor: Color(0xFF706677),
    ),
    CustomTheme(
      primaryColor: Color(0xFFB22727),
      backgroundColor: Color(0xFF006E7F),
      selectedIconColor: Color(0xFFEE5007),
      unselectedIconColor: Color(0xFF006E7F),
      darkTextColor: Color(0xFFF8CB2E),
      mediumTextColor: Color(0xFFEFD345),
    ),
    CustomTheme(
      primaryColor: Color(0xFFFF6F3C),
      backgroundColor: Color(0xFF155263),
      selectedIconColor: Color(0xFFFF6F3C),
      unselectedIconColor: Color(0xFF155263),
      darkTextColor: Color(0xFFFF9A3C),
      mediumTextColor: Color(0xFFFFC93C),
    ),
    CustomTheme(
      primaryColor: Color(0xFF7579E7),
      backgroundColor: Color(0xFF7579E7),
      selectedIconColor: Color(0xFF7579E7),
      unselectedIconColor: Color(0xFF9AB3F5),
      darkTextColor: Color(0xFF9AB3F5),
      mediumTextColor: Color(0xFFB9FFFC),
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
