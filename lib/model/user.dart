import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  /// 初期値
  String _username = "sample";

  String get name => _username;

  /// name の更新メソッド
  set name(String n) {
    if (n.isNotEmpty && _username == "sample") {
      _username = n;
      notifyListeners();
    } else {
      _username = "sample";
      notifyListeners();
    }
  }
}
