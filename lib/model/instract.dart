import 'package:flutter/material.dart';

// TODO: データベースとのやりとり
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

  // 単体のinstractを入れる
  void addInstract(String category, Instract instract) {
    if (instractsList[category] != null) {
      instractsList[category]!.add(instract);
    } else {
      List<Instract> instracts = [instract];
      Map<String, List<Instract>> newInstractsList = {category: instracts};
      instractsList.addAll(newInstractsList);
    }
    // Debug
    instractsList[category]!
        .forEach((Instract instract) => {print(instract._answers)});
    notifyListeners();
  }

  // 複数のinstractを入れる
  void addMultiInstract(String category, List<Instract> instractList) {
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

  set question(String question) {
    if (question.isNotEmpty) {
      _question = question;
    }
  }

  set answers(List<String> answers) {
    if (answers.isNotEmpty) {
      _answers = answers;
    }
  }

  void addAnswers(List<String> answers) {
    if (answers.isNotEmpty) {
      _answers = [..._answers, ...answers];
    }
  }
}
