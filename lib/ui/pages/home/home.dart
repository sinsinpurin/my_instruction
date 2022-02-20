import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
// import 'package:my_instruction/model/user.dart';
import 'package:my_instruction/ui/components/create_button.dart';
import 'package:my_instruction/ui/pages/category/category.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final User userStore = Provider.of<User>(context);
    final InstractsStore instractsStore = Provider.of<InstractsStore>(context);

    return Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 15),
                  child: const Text(
                    "じぶん説明書",
                    style: TextStyle(fontSize: 20),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: instractsStore.categoryList.length,
              itemBuilder: (context, index) {
                if (instractsStore.categoryList == []) {
                  return const SizedBox.shrink();
                }
                return _listItem(context, instractsStore.categoryList[index]);
              },
            )),
          ],
        ),
        floatingActionButton: const CreateButton());
  }

  Widget _listItem(BuildContext context, Category categoryObj) {
    return Column(
      children: [
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  categoryObj.category,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          settings: const RouteSettings(name: "/category"),
                          builder: (BuildContext context) =>
                              CategoryPage(categoryObj: categoryObj)));
                },
              ),
            )),
      ],
    );
  }
}
