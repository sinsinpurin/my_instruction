import 'package:flutter/material.dart';

// TODO: データベースとのやりとり
class Instracts extends ChangeNotifier {
  // 初期値
  Map<String, List<Instract>> instractsList = {};

  Instracts() {
    instractsList = {
      "Health Care": [
        Instract(0, "疲れたらどうすればいい？", ["寝たらいい", "ストレス発散しよう"])
      ],
      "Education": [
        Instract(0, "勉強疲れた", ["寝たらいい"])
      ],
      "Life": [
        Instract(0, "朝起きれない", ["早寝しよう"])
      ],
    };
  }

  // 単体のinstractを入れる
  void addInstract(
      String category, int id, String question, List<String> answers) {
    if (instractsList[category] != null) {
      instractsList[category]!.add(Instract(id, question, answers));
    } else {
      List<Instract> instracts = [Instract(id, question, answers)];
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

  void updateInstract(String category, Instract instract) {
    if (instractsList[category] != null) {
      instractsList[category]![instract.id] = instract;
    }
  }

  void removeInstract(String category, Instract instract) {
    //;
  }
}

// TODO: categoryを入れた方がいいかも
class Instract {
  /// 初期値
  int _id = 0;
  String _question = "Null Question";
  List<String> _answers = ["Null Answer"];

  Instract(id, question, answers) {
    _id = id;
    _question = question;
    _answers = answers;
  }

  int get id => _id;
  String get question => _question;
  List<String> get answers => _answers;

  set index(int i) {
    _id = i;
  }

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
