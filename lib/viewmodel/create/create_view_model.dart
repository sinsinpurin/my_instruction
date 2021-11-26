import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';

enum Mode { create, edit }

class CreateViewModel extends ChangeNotifier {
  String _inputCategory = "新しいカテゴリ";
  String _inputNewCategory = "";
  String _inputQuestion = "";
  List<String> _inputAnswers = [""];
  int _inputAnswersNum = 1;
  Mode _mode = Mode.create;

  String get inputCategory => _inputCategory;
  String get inputNewCategory => _inputNewCategory;
  String get inputQuestion => _inputQuestion;
  List<String> get inputAnswers => _inputAnswers;
  int get inputAnswersNum => _inputAnswersNum;
  Mode get mode => _mode;

  set mode(Mode mode) {
    _mode = mode;
    notifyListeners();
  }

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
    _inputAnswers[index] = answer;
    notifyListeners();
  }

  void allClear() {
    _inputCategory = "新しいカテゴリ";
    _inputNewCategory = "";
    _inputQuestion = "";
    _inputAnswers = [""];
    _inputAnswersNum = 1;
    _mode = Mode.create;

    //いらんかも
    notifyListeners();
  }

  Future<void> loadInstract(
      int instractId, InstractsStore instractsStore, Mode mode) async {
    if (mode == Mode.edit) {
      Instract instract = await instractsStore.getInstract(instractId);
      _inputCategory =
          await instractsStore.getCategoryById(instract.categoryId);
      _inputQuestion = instract.question;
      _inputAnswers = instract.answers;
      _inputAnswersNum = instract.answers.length;
      _mode = mode;
    } else if (mode == Mode.create) {
      //_inputCategory = await instractsStore.getDropDownButtonCatgoryList();
    }

    //いらんかも
    notifyListeners();
  }
}
