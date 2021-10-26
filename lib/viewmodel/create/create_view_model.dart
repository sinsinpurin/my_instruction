import 'package:flutter/material.dart';

class CreateViewModel extends ChangeNotifier {
  String _inputCategory = "";
  String _inputQuestion = "";
  List<String> _inputAnswers = [""];
  int _inputAnswersNum = 1;

  String get inputCategory => _inputCategory;
  String get inputQuestion => _inputQuestion;
  List<String> get inputAnswers => _inputAnswers;
  int get inputAnswersNum => _inputAnswersNum;

  set inputCategory(String category) {
    _inputCategory = category;
    notifyListeners();
  }

  set inputQuestion(String question) {
    _inputQuestion = question;
    notifyListeners();
  }

  set inputAnswersNum(int i) {
    _inputAnswersNum = i;
    notifyListeners();
  }

  void addAnswer(int index, String answer) {
    _inputAnswers[index] = answer;
    notifyListeners();
  }

  void allClear() {
    _inputQuestion = "";
    _inputCategory = "";
    _inputAnswers = [];
    _inputAnswersNum = 1;
    notifyListeners();
  }

// TODO: 登録ロジックを書く
  void submit(String question, String category, List<String> answers) {}
}
