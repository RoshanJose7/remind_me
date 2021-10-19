import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme {
  final Color primaryColor;
  final Color backgroundColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;

  CustomTheme({
    required this.primaryColor,
    required this.backgroundColor,
    required this.selectedIconColor,
    required this.unselectedIconColor,
  });
}

class Themes with ChangeNotifier {
  int _themeIdx = 0;
  List<CustomTheme> _themes = [
    CustomTheme(
      primaryColor: Colors.blueAccent[400] as Color,
      backgroundColor: Colors.blue[200] as Color,
      selectedIconColor: Colors.blueAccent[100] as Color,
      unselectedIconColor: Colors.blue[100] as Color,
    ),
    CustomTheme(
      primaryColor: Colors.redAccent[400] as Color,
      backgroundColor: Colors.red[200] as Color,
      selectedIconColor: Colors.redAccent[100] as Color,
      unselectedIconColor: Colors.red[100] as Color,
    ),
    CustomTheme(
      primaryColor: Colors.greenAccent[400] as Color,
      backgroundColor: Colors.green[200] as Color,
      selectedIconColor: Colors.greenAccent[100] as Color,
      unselectedIconColor: Colors.green[100] as Color,
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
