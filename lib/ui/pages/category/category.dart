import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/ui/components/create_button.dart';
import 'package:my_instruction/ui/pages/instract/instract.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key, required this.category}) : super(key: key) {
    //;
  }

  final String category;

  @override
  Widget build(BuildContext context) {
    final Instracts instractsStore = Provider.of<Instracts>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Column(children: [
        Expanded(
            child: (() {
          if (instractsStore.instractsList[category] == null) {
            //instractが存在しない場合
            return const Center(
              child: Text("No Instracts"),
            );
          }
          return ListView.builder(
              itemCount: instractsStore.instractsList[category]!.length,
              itemBuilder: (BuildContext context, int index) {
                return _listItem(
                    context, instractsStore.instractsList[category]![index]);
              });
        }())),
      ]),
      floatingActionButton: const CreateButton(),
    );
  }

  Widget _listItem(BuildContext context, Instract instract) {
    return Column(
      children: [
        ListTile(
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
                        InstractPage(instract: instract, category: category)));
          },
        ),
        const Divider()
      ],
    );
  }
}
