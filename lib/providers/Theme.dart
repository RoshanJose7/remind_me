import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes with ChangeNotifier {
  int _themeIdx = 0;
  List<Color> _themes = [
    Color(0xFF3F33C7),
    Color(0xFFFF735C),
    Color(0xFF425DCE),
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

  Color get theme {
    return _themes[_themeIdx];
  }

  void storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeIdx', _themeIdx.toString());
  }

  void changeTheme({required int idx}) {
    _themeIdx = idx;
    notifyListeners();
  }
}
