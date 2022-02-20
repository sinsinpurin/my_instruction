import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
//import 'package:my_instruction/model/user.dart';
import 'package:my_instruction/viewmodel/create/create_view_model.dart';
import 'package:my_instruction/viewmodel/create/instract_view_model.dart';
import 'package:provider/provider.dart';
import 'ui/pages/home/home.dart';
import 'package:my_instruction/repository/db_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

void main() async {
  // main内に変数を宣言する場合はWidgetsFlutterBinding.ensureInitialized()を実行する
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
    Isar isar = await Isar.open(
      schemas: [RepositoryCategorySchema,RepositoryInstractSchema],
      directory: dir.path,
      inspector: true
    );
  runApp(MultiProvider(providers: [
//    ChangeNotifierProvider(create: (context) => User()),
    ChangeNotifierProvider(create: (context) => InstractsStore(isar: isar)),
    ChangeNotifierProvider(create: (context) => InstractViewModel(isar: isar)),
    ChangeNotifierProvider(create: (context) => CreateViewModel())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'じぶん説明書',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
