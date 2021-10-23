import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/ui/pages/instract/instract.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key, required this.category}) : super(key: key) {
    //;
  }

  final String category;

  @override
  Widget build(BuildContext context) {
    final Instracts instracts = Provider.of<Instracts>(context);
    instracts.instractsList = instracts.getCategoryInstractsList(category);
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: instracts.instractsList.length,
          itemBuilder: (context, index) {
            return _listItem(context, instracts.instractsList[index]);
          },
        )),
      ]),
    );
  }

  Widget _listItem(BuildContext context, Instract instract) {
    return ListTile(
      title: Text(
        instract.question,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<Void>(
                settings: const RouteSettings(name: "/instract"),
                builder: (BuildContext context) =>
                    InstractPage(instract: instract)));
      },
    );
  }
}
