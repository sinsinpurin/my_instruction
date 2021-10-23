import 'package:flutter/material.dart';

class Instracts extends ChangeNotifier {
  // 初期値
  List<Instract> _instractsList = [];

  Instracts() {
    _instractsList = [
      Instract("Health Care", "疲れたらどうすればいい？", ["寝たらいい"]),
      Instract("Sports", "疲れたらどうすればいい？", ["寝たらいい"]),
      Instract("Health Care", "疲れたらどうすればいい？", ["寝たらいい"]),
    ];
  }

  List<Instract> get instractsList => _instractsList;

  set instractsList(List<Instract> list) {
    _instractsList = list;
    notifyListeners();
  }

  void addList(Instract instract) {
    _instractsList = [..._instractsList, instract];
  }

  List<Instract> getCategoryInstractsList(String category) {
    List<Instract> list = [];
    for (Instract instract in _instractsList) {
      if (instract.category == category) {
        list = [...list, instract];
      }
    }
    notifyListeners();
    return list;
  }
}

class Instract {
  /// 初期値
  String _category = "Null Category";
  String _question = "Null Question";
  List<String> _answers = ["Null Answer"];

  Instract(category, question, answers) {
    _category = category;
    _question = question;
    _answers = answers;
  }

  String get category => _category;
  String get question => _question;
  List<String> get answers => _answers;

  set category(String s) {
    _category = "Changed Category";
  }

  set question(String s) {
    if (s.isNotEmpty) {
      _question = s;
    }
  }

  set answers(List<String> s) {
    if (s.isNotEmpty) {
      _answers = s;
    }
  }
}
