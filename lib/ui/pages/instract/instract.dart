import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/ui/pages/edit/edit.dart';

class InstractPage extends StatelessWidget {
  const InstractPage({Key? key, required this.instract, required this.category})
      : super(key: key);

  final Instract instract;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Question",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<Void>(
                        settings: const RouteSettings(name: "/edit"),
                        builder: (BuildContext context) =>
                            EditPage(instract: instract, category: category)));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Center(
            child: Text(
              instract.question,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // TODO: なぜか中央寄せになってしまっている
        const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              "Answer",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
        Expanded(
            child: ListView.builder(
          itemCount: instract.answers.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(
                  instract.answers[index],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.favorite));
          },
        ))
      ]),
    );
  }
}
