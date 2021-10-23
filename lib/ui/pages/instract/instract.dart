import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';

class InstractPage extends StatelessWidget {
  InstractPage({Key? key, required this.instract}) : super(key: key) {
    //;
  }

  final Instract instract;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("じぶん説明書"),
      ),
      body: Column(children: [
        Center(
          child: Text(instract.question),
        ),
        // Expanded(
        //     child: ListView.builder(
        //   itemCount: instracts.instractsList.length,
        //   itemBuilder: (context, index) {
        //     return _listItem(context, instracts.instractsList[index]);
        //   },
        // )),
      ]),
    );
  }
}
