import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/model/user.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User userState = Provider.of<User>(context);
    final Instracts instractsState = Provider.of<Instracts>(context);
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
              itemCount: instractsState.instracts.length,
              itemBuilder: (context, index) {
                return _listItem(
                    context, instractsState.instracts[index].category);
              },
            )),
          ],
        ));
  }

  Widget _listItem(BuildContext context, String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/category');
      },
    );
  }
}
