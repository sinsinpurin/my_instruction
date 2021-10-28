import 'package:flutter/material.dart';

enum Mode { create, edit }

class CreateViewModel extends ChangeNotifier {
  String _inputCategory = "";
  String _inputNewCategory = "";
  String _inputQuestion = "";
  List<String> _inputAnswers = [""];
  int _inputAnswersNum = 1;
  Mode mode = Mode.create;

  String get inputCategory => _inputCategory;
  String get inputNewCategory => _inputNewCategory;
  String get inputQuestion => _inputQuestion;
  List<String> get inputAnswers => _inputAnswers;
  int get inputAnswersNum => _inputAnswersNum;

  set inputCategory(String category) {
    _inputCategory = category;
    notifyListeners();
  }

  set inputNewCategory(String newCategory) {
    _inputNewCategory = newCategory;
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

  void addAnswer() {
    _inputAnswers.add("");
  }

  void deleteAnswer() {
    _inputAnswers.removeLast();
  }

  void updateAnswer(int index, String answer) {
    if (_inputAnswers.length == index + 1) {
      _inputAnswers[index] = answer;
      notifyListeners();
    }
  }

  void allClear() {
    _inputCategory = "";
    _inputNewCategory = "";
    _inputQuestion = "";
    _inputAnswers = [""];
    _inputAnswersNum = 1;
    mode = Mode.create;

    //いらんかも
    notifyListeners();
  }

  void loadInstract(String category, String question, List<String> answers) {
    _inputCategory = category;
    _inputQuestion = question;
    _inputAnswers = answers;
    _inputAnswersNum = answers.length;
    mode = Mode.edit;

    //いらんかも
    notifyListeners();
  }
}
