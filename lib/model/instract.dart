import 'package:flutter/material.dart';

class Instracts extends ChangeNotifier {
  // 初期値
  List<Instract> _instracts = [
    Instract("Health Care", "疲れたらどうすればいい？", "寝たらいい"),
    Instract("Sports", "疲れたらどうすればいい？", "寝たらいい"),
    Instract("Health Care", "疲れたらどうすればいい？", "寝たらいい"),
  ];

  List<Instract> get instracts => _instracts;

  set instracts(List<Instract> list) {
    _instracts = list;
    notifyListeners();
  }

  void addList(Instract instract) {
    _instracts = [..._instracts, instract];
  }
}

class Instract {
  /// 初期値
  String _category = "Null Category";
  String _question = "Null Question";
  String _answer = "Null Answer";

  Instract(category, question, answer) {
    _category = category;
    _question = question;
    _answer = answer;
  }

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
