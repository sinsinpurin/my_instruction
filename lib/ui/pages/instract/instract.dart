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
            title: const Text("質問",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
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
                child: Material(
                    child: Text(
                  instract.question,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 50, left: 15),
              child: const Text(
                "Answer",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.topLeft,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: instract.answers.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                  instract.answers[index],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )
                    // trailing: const Icon(Icons.favorite)
                    );
              },
            ))
          ]),
        ));
  }
}
