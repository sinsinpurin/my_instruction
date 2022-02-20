import 'package:isar/isar.dart';
import 'db_model.dart';
import 'package:my_instruction/repository/db_model.dart';
import 'package:my_instruction/model/instract.dart';

class DBHelper {
  final Isar isar;

  DBHelper({required this.isar});

  Future<IsarCollection<RepositoryCategory>> getCategoryRepo() async {
    return isar.repositoryCategorys;
  }

  Future<IsarCollection<RepositoryInstract>> getInstractRepo() async {
    return isar.repositoryInstracts;
  }

  Future<List<Category>> getAllCategory() async {
    var categoryRepo = await getCategoryRepo();
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
    var instractRepo = await getInstractRepo();
    List<RepositoryInstract> instractList =
        await instractRepo.where().findAll();
    List<Instract> rInstractlist = [];
    for (var instract in instractList) {
      rInstractlist.add(Instract(instract.categoryId, instract.instractId!,
          instract.question, instract.answers));
    }
    return rInstractlist;
  }

  Future<Instract> getInstracts(int id) async {
    var instractRepo = await getInstractRepo();
    final inst = await instractRepo.get(id);
    if (inst == null) {
      throw Exception("idに紐ずくinstractがdbにないよ");
    } else {
      return Instract(
          inst.categoryId, inst.instractId!, inst.question, inst.answers);
    }
  }

  Future<List<Instract>> getInstractsByCategoryID(int categoryId) async {
    var instractRepo = await getInstractRepo();
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

  Future<String> getCategoryName(int id) async {
    var categoryRepo = await getCategoryRepo();
    final categoryObj = await categoryRepo.get(id);
    if (categoryObj == null) {
      throw Exception("idに紐ずくcateogryがdbにないよ");
    } else {
      return categoryObj.category;
    }
  }

  Future<int> getIdByCategory(String category) async {
    var categoryRepo = await getCategoryRepo();
    RepositoryCategory? queryCategory = await categoryRepo
        .where()
        .filter()
        .categoryEqualTo(category)
        .findFirst();
    if (queryCategory == null || queryCategory.categoryId == null) {
      throw Exception("cateogryに紐ずくidがdbにないよ");
    } else {
      return queryCategory.categoryId!;
    }
  }

  Future<void> addInstractRepo(
      int categoryId, String question, List<String> answers) async {
      var instractRepo = await getInstractRepo();
    final newInstract = RepositoryInstract()
      ..categoryId = categoryId
      ..question = question
      ..answers = answers;
    await isar.writeTxn((isar) async {
      await instractRepo.put(newInstract);
    });
  }

  Future<void> updateInstractRepo(int instractId, int categoryId,
      String question, List<String> answers) async {
      var instractRepo = await getInstractRepo();
    final newInstract = RepositoryInstract()
      ..instractId = instractId
      ..categoryId = categoryId
      ..question = question
      ..answers = answers;
    await isar.writeTxn((isar) async {
      await instractRepo.put(newInstract);
    });
  }

  Future<void> deleteInstractRepo(int instractId) async {
    var instractRepo = await getInstractRepo();
    await isar.writeTxn((isar) async {
      instractRepo.delete(instractId);
    });
  }

  Future<void> deleteCategoryRepo(int categoryId) async {
    var categoryRepo = await getCategoryRepo();
    await isar.writeTxn((isar) async {
      categoryRepo.delete(categoryId);
    });
  }

  Future<void> addCategoryRepo(String category) async {
    final newCategory = RepositoryCategory()..category = category;
    var categoryRepo = await getCategoryRepo();
    await isar.writeTxn((isar) async {
      await categoryRepo.put(newCategory);
    });
  }
}
