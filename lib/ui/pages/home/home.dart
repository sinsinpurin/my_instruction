import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/model/user.dart';
import 'package:my_instruction/ui/pages/category/category.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User userState = Provider.of<User>(context);
    final Instracts instracts = Provider.of<Instracts>(context);
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
              userState.name,
              style: const TextStyle(fontSize: 30),
            )),
            TextButton(
                onPressed: () => {userState.name = "masaki"},
                child: const Text("Change Name")),
            Expanded(
                child: ListView.builder(
              itemCount: instracts.instractsList.length,
              itemBuilder: (context, index) {
                return _listItem(
                    context, instracts.instractsList[index].category);
              },
            )),
          ],
        ));
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
