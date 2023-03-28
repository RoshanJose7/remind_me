import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainState with ChangeNotifier {
  bool _hideIntro = false;
  String _userName = "User";
  String _picPath = "assets/img/avatar.png";

  MainState() {
    getData();
  }

  String get userName {
    return _userName;
  }

  String get picPath {
    return _picPath;
  }

  bool get hideIntro {
    return _hideIntro;
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var temp1 = prefs.getString('userName');
    var temp2 = prefs.getString('picPath');
    var temp3 = prefs.getString('hideIntro');

    if (temp1 != null && temp2 != null && temp3 != null) {
      _userName = temp1;
      _picPath = temp2;
      _hideIntro = temp3 == 'true' ? true : false;
      notifyListeners();
    }
  }

  void storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', _userName);
    prefs.setString('picPath', _picPath);
    prefs.setString('hideIntro', _hideIntro.toString());
  }

  void updateUserName({required String name}) {
    _userName = name;
    storeData();
    notifyListeners();
  }

  void updatePicPath({required String path}) {
    _picPath = path;
    storeData();
    notifyListeners();
  }

  void updateHideIntro({required bool val}) {
    _hideIntro = val;
    storeData();
    notifyListeners();
  }
}
