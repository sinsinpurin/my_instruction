import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:my_instruction/isar.g.dart';
import 'package:my_instruction/repository/db_helper.dart';

class InstractsStore extends ChangeNotifier {
  late DBHelper db;

  List<Category> _categoryList = [];
  List<Instract> _instractList = [];

  InstractsStore() {
    initialize();
  }

  initialize() async {
    Isar isar = await openIsar();
    db = DBHelper(isar: isar);
    _categoryList = await db.getAllCategory();
    notifyListeners();
  }

  List<Category> get categoryList => _categoryList;
  List<Instract> get instractList => _instractList;

  Instract getInstract(int id) {
    return db.getInstracts(id);
  }

  String getCategoryById(int id) {
    return db.getCategoryName(id);
  }

  void refleshStore() async {
    _categoryList = await db.getAllCategory();
    notifyListeners();
  }

  void setInstractByCategoryID(int categoryId) async {
    _instractList = await db.getInstractsByCategoryID(categoryId);
    notifyListeners();
  }

  void addInstract(int categoryId, String question, List<String> answers) {
    db.addInstractRepo(categoryId, question, answers);
    refleshStore();
    notifyListeners();
  }

  void addCategory(String category) {
    db.addCategoryRepo(category);
    refleshStore();
    notifyListeners();
  }

  int getLatestCategoryId() {
    return _categoryList[_categoryList.length - 1]._categoryId;
  }

  void updateInstract(
      int instractId, int categoryId, String question, List<String> answers) {
    db.updateInstractRepo(instractId, categoryId, question, answers);
    refleshStore();
    notifyListeners();
  }
}

class Category extends ChangeNotifier {
  // 初期値
  final int _categoryId;
  final String _category;
  Category(this._categoryId, this._category);

  int get categoryId => _categoryId;
  String get category => _category;
}

class Instract extends ChangeNotifier {
  /// 初期値
  final int _categoryId;
  final int _id;
  final String _question;
  final List<String> _answers;

  Instract(this._categoryId, this._id, this._question, this._answers);

  int get categoryId => _categoryId;
  int get id => _id;
  String get question => _question;
  List<String> get answers => _answers;
}
