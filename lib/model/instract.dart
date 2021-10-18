import 'package:flutter/material.dart';

class Instracts extends ChangeNotifier {
  // 初期値
  List<Instract> _instracts = [Instract()];

  List<Instract> get instracts => _instracts;

  set instracts(List<Instract> list) {
    _instracts = list;
    notifyListeners();
  }

  void addList(Instract instract) {
    _instracts = [..._instracts, instract];
  }
}

class Instract extends ChangeNotifier {
  /// 初期値
  String _category = "Sample Category";
  String _question = "Sample Question";
  String _answer = "Sample Answer";

  String get category => _category;
  String get question => _question;
  String get answer => _answer;

  set category(String s) {
    _category = "Changed Category";
  }

  set question(String s) {
    if (s.isNotEmpty) {
      _question = s;
    }
  }

  set answer(String s) {
    if (s.isNotEmpty) {
      _answer = s;
    }
  }
}
