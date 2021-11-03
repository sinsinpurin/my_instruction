import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:my_instruction/isar.g.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/repository/db_helper.dart';

class InstractViewModel extends ChangeNotifier {
  Instract _instract = Instract(0, 0, "", [""]);
  Category _category = Category(0, "");
  late DBHelper db;

  InstractViewModel() {
    initialize();
  }

  initialize() async {
    Isar isar = await openIsar();
    db = DBHelper(isar: isar);
    notifyListeners();
  }

  Instract get instract => _instract;
  set instract(Instract instract) {
    _instract = instract;
    notifyListeners();
  }

  Category get category => _category;
  set category(Category category) {
    _category = category;
    notifyListeners();
  }

  Future<Instract> getInstract(int id) async {
    return await db.getInstracts(id);
  }

  Future<String> getCategoryById(int id) async {
    return await db.getCategoryName(id);
  }

  Future<void> loadInstract(int id) async {
    _instract = await getInstract(id);
    notifyListeners();
  }

  Future<void> loadCategory(int categoryId) async {
    _category = Category(categoryId, await getCategoryById(categoryId));
    notifyListeners();
  }
}
