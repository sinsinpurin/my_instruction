import 'package:flutter/material.dart';

class Instracts extends ChangeNotifier {
  // 初期値
  Map<String, List<Instract>> instractsList = {};

  Instracts() {
    instractsList = {
      "Health Care": [
        Instract("疲れたらどうすればいい？", ["寝たらいい"])
      ],
      "Education": [
        Instract("勉強疲れた", ["寝たらいい"])
      ],
      "Life": [
        Instract("朝起きれない", ["早寝しよう"])
      ],
    };
  }

  void addInstract(String category, List<Instract> instractList) {
    if (instractsList[category] != null) {
      for (Instract instract in instractList) {
        instractsList[category]!.add(instract);
      }
    } else {
      Map<String, List<Instract>> newInstractsList = {category: instractList};
      instractsList.addAll(newInstractsList);
    }
    notifyListeners();
  }

  void removeInstract(String category, Instract instract) {
    //;
  }
}

class Instract {
  /// 初期値
  String _question = "Null Question";
  List<String> _answers = ["Null Answer"];

  Instract(question, answers) {
    _question = question;
    _answers = answers;
  }

  String get question => _question;
  List<String> get answers => _answers;

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

  // TODO: ロジックを書く
  void addAnswers(List<String> s) {}
}
