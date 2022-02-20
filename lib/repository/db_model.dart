import 'package:isar/isar.dart';

part 'db_model.g.dart';

@Collection()
@Name("CategoryList")
class RepositoryCategory {
  @Id()
  @Name("categoryId")
  int? categoryId;

  @Name("category")
  late String category;
}

@Collection()
@Name("Instract")
class RepositoryInstract {
  @Id()
  @Name("instractId")
  int? instractId;

  @Name("categoryId")
  late int categoryId;

  @Name("question")
  late String question;

  @Name("answers")
  late List<String> answers;
}
