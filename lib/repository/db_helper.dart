import 'package:isar/isar.dart';
import 'package:my_instruction/isar.g.dart';
import 'package:my_instruction/repository/db_model.dart';

import 'package:my_instruction/model/instract.dart';

class DBHelper {
  final Isar isar;
  late IsarCollection<RepositoryCategory> categoryRepo;
  late IsarCollection<RepositoryInstract> instractRepo;
  DBHelper({required this.isar}) {
    categoryRepo = isar.repositoryCategorys;
    instractRepo = isar.repositoryInstracts;
  }

  Future<List<Category>> getAllCategory() async {
    List<RepositoryCategory> categoryList =
        await categoryRepo.where().findAll();
    List<Category> rCategoryList = [];
    for (var categoryObj in categoryList) {
      rCategoryList
          .add(Category(categoryObj.categoryId!, categoryObj.category));
    }
    return rCategoryList;
  }

  Future<List<Instract>> getAllInstract() async {
    List<RepositoryInstract> instractList =
        await instractRepo.where().findAll();
    List<Instract> rInstractlist = [];
    for (var instract in instractList) {
      rInstractlist.add(Instract(instract.categoryId, instract.instractId!,
          instract.question, instract.answers));
    }
    return rInstractlist;
  }

  Instract getInstracts(int id) {
    final inst = instractRepo.getSync(id);
    if (inst == null) {
      throw Exception("idに紐ずくinstractがdbにないよ");
    } else {
      return Instract(
          inst.categoryId, inst.instractId!, inst.question, inst.answers);
    }
  }

  Future<List<Instract>> getInstractsByCategoryID(int categoryId) async {
    List<RepositoryInstract> instractList = await instractRepo
        .where()
        .filter()
        .categoryIdEqualTo(categoryId)
        .findAll();
    List<Instract> rInstractlist = [];
    for (var instract in instractList) {
      rInstractlist.add(Instract(instract.categoryId, instract.instractId!,
          instract.question, instract.answers));
    }
    return rInstractlist;
  }

  String getCategoryName(int id) {
    final categoryObj = categoryRepo.getSync(id);
    if (categoryObj == null) {
      throw Exception("idに紐ずくcateogryがdbにないよ");
    } else {
      return categoryObj.category;
    }
  }

  void addInstractRepo(
      int categoryId, String question, List<String> answers) async {
    final newInstract = RepositoryInstract()
      ..categoryId = categoryId
      ..question = question
      ..answers = answers;
    await isar.writeTxn((isar) async {
      await instractRepo.put(newInstract);
    });
  }

  void updateInstractRepo(int instractId, int categoryId, String question,
      List<String> answers) async {
    final newInstract = RepositoryInstract()
      ..instractId = instractId
      ..categoryId = categoryId
      ..question = question
      ..answers = answers;
    await isar.writeTxn((isar) async {
      await instractRepo.put(newInstract);
    });
  }

  void addCategoryRepo(String category) async {
    final newCategory = RepositoryCategory()..category = category;
    await isar.writeTxn((isar) async {
      await categoryRepo.put(newCategory);
    });
  }
}