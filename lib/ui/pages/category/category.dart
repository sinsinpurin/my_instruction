import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/ui/components/create_button.dart';
import 'package:my_instruction/ui/pages/instract/instract.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key, required this.categoryObj}) : super(key: key);

  final Category categoryObj;

  @override
  Widget build(BuildContext context) {
    final InstractsStore instractsStore = Provider.of<InstractsStore>(context);
    instractsStore.setInstractByCategoryID(categoryObj.categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryObj.category),
      ),
      body: Column(children: [
        if (instractsStore.instractList.isEmpty)
          Column(
            children: [
              const Center(child: Text("Q&A がありません")),
              IconButton(
                  onPressed: () async {
                    await instractsStore.deleteCategory(categoryObj.categoryId);
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        Expanded(
            child: (() {
          return ListView.builder(
              itemCount: instractsStore.instractList.length,
              itemBuilder: (BuildContext context, int index) {
                return _listItem(context, instractsStore.instractList[index]);
              });
        }())),
      ]),
      floatingActionButton: const CreateButton(),
    );
  }

  Widget _listItem(BuildContext context, Instract instract) {
    return Column(
      children: [
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  instract.question,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<Void>(
                          settings: const RouteSettings(name: "/instract"),
                          builder: (BuildContext context) =>
                              InstractPage(instractId: instract.id)));
                },
              ),
            )),
      ],
    );
  }
}
