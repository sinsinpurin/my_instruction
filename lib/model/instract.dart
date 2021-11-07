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

  Future<Instract> getInstract(int id) async {
    return await db.getInstracts(id);
  }

  Future<String> getCategoryById(int id) async {
    return await db.getCategoryName(id);
  }

  Future<int> getIdByCategory(String category) async {
    int id = await db.getIdByCategory(category);
    return id;
  }

  Future<void> refleshCategoryList() async {
    _categoryList = await db.getAllCategory();
    notifyListeners();
  }

  Future<void> refleshInstractList(int categoryId) async {
    await setInstractByCategoryID(categoryId);
    notifyListeners();
  }

  Future<void> setInstractByCategoryID(int categoryId) async {
    _instractList = await db.getInstractsByCategoryID(categoryId);
    notifyListeners();
  }

  Future<void> addInstract(
      int categoryId, String question, List<String> answers) async {
    await db.addInstractRepo(categoryId, question, answers);
    await refleshCategoryList();
    notifyListeners();
  }

  Future<void> deleteInstract(int instractId, int categoryId) async {
    await db.deleteInstractRepo(instractId);
    List<Instract> instractlistTmp =
        await db.getInstractsByCategoryID(categoryId);
    if (instractlistTmp.isEmpty) {
      await db.deleteCategoryRepo(categoryId);
      await refleshCategoryList();
      await refleshInstractList(categoryId);
    }
    notifyListeners();
  }

  Future<void> addCategory(String category) async {
    await db.addCategoryRepo(category);
    await refleshCategoryList();
    notifyListeners();
  }

  Future<void> updateInstract(int instractId, int categoryId, String question,
      List<String> answers) async {
    await db.updateInstractRepo(instractId, categoryId, question, answers);
    await refleshInstractList(categoryId);
    notifyListeners();
  }

  List<Category> getDropDownButtonCatgoryList() {
    List<Category> DDBCList = [Category(0, "new"), ..._categoryList];
    return DDBCList;
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
