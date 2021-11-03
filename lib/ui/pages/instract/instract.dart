import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_instruction/util/initializer.dart';
import 'package:my_instruction/viewmodel/create/instract_view_model.dart';
import 'package:provider/provider.dart';

import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/ui/pages/edit/edit.dart';

class InstractPage extends StatelessWidget {
  const InstractPage({Key? key, required this.instractId}) : super(key: key);

  final int instractId;

  @override
  Widget build(BuildContext context) {
    final InstractViewModel instractViewModel =
        Provider.of<InstractViewModel>(context);
    Instract instract = instractViewModel.instract;
    return InitializerWrapper(
        onInit: () {
          Future(() async {
            await instractViewModel.loadInstract(instractId);
          });
        },
        child: Scaffold(
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
                                EditPage(instract: instract)));
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
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
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
        ));
  }
}
