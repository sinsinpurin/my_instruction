import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/model/user.dart';
import 'package:my_instruction/ui/pages/category/category.dart';
import 'package:my_instruction/ui/pages/create/create.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User userStore = Provider.of<User>(context);
    final Instracts instractsStore = Provider.of<Instracts>(context);

    List<String> categoryList = [];

    for (var key in instractsStore.instractsList.keys) {
      categoryList.add(key);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("じぶん説明書"),
      ),
      body: Column(
        children: [
          const Center(
            child: Icon(Icons.person, size: 200),
          ),
          Center(
              child: Text(
            userStore.name,
            style: const TextStyle(fontSize: 30),
          )),
          Container(
            padding: const EdgeInsets.only(left: 15),
            child: const Text(
              "Category",
              style: TextStyle(fontSize: 20),
            ),
            alignment: Alignment.topLeft,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: instractsStore.instractsList.length,
            itemBuilder: (context, index) {
              if (categoryList == []) {
                return Container();
              }
              return _listItem(context, categoryList[index]);
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreatePage(),
            ),
          );
        },
      ),
    );
  }

  Widget _listItem(BuildContext context, String category) {
    return ListTile(
      title: Text(
        category,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<Void>(
                settings: const RouteSettings(name: "/category"),
                builder: (BuildContext context) =>
                    CategoryPage(category: category)));
      },
    );
  }
}
