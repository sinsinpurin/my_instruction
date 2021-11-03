import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';

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

  void loadInstract(int instractId, InstractsStore instractsStore) {
    Instract instract = instractsStore.getInstract(instractId);
    _inputCategory = instractsStore.getCategoryById(instract.categoryId);
    _inputQuestion = instract.question;
    _inputAnswers = instract.answers;
    _inputAnswersNum = instract.answers.length;
    mode = Mode.edit;

    //いらんかも
    notifyListeners();
  }
}
