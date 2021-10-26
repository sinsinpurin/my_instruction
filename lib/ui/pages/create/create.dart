import 'package:flutter/material.dart';
import 'package:my_instruction/viewmodel/create/create_view_model.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateViewModel createViewModel =
        Provider.of<CreateViewModel>(context);
    final Instracts instractsStore = Provider.of<Instracts>(context);

    List<DropdownMenuItem<String>> categoryList = [
      const DropdownMenuItem(child: Text("Select Category"), value: "")
    ];
    categoryList
        .add(const DropdownMenuItem(child: Text("New Category"), value: "new"));
    for (var key in instractsStore.instractsList.keys) {
      categoryList.add(DropdownMenuItem(child: Text(key), value: key));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Q&A"),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 30, top: 100),
          child: const Text("Category", style: TextStyle(fontSize: 20)),
          alignment: Alignment.topLeft,
        ),
        Container(
          padding: const EdgeInsets.only(left: 30),
          child: DropdownButton<String>(
            items: categoryList,
            value: createViewModel.inputCategory,
            onChanged: (category) {
              if (category != "" && category != null) {
                createViewModel.inputCategory = category;
              }
            },
          ),
          alignment: Alignment.topLeft,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 30, right: 15),
            child: (() {
              if (createViewModel.inputCategory == "new") {
                return TextField(
                  maxLength: 30,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a Category',
                  ),
                  onChanged: (text) {
                    createViewModel.inputQuestion = text;
                  },
                );
              } else {}
            }())),
        Container(
          padding: const EdgeInsets.only(left: 30, top: 30),
          child: const Text("Question", style: TextStyle(fontSize: 20)),
          alignment: Alignment.topLeft,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 30, right: 15),
            child: TextField(
              maxLength: 30,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a Question',
              ),
              onChanged: (text) {
                createViewModel.inputQuestion = text;
              },
            )),
        Container(
          padding: const EdgeInsets.only(left: 30, top: 7),
          child: Row(
            children: [
              const Text("Answer", style: TextStyle(fontSize: 20)),
              TextButton(
                  onPressed: () {
                    createViewModel.addAnswer();
                    createViewModel.inputAnswersNum =
                        createViewModel.inputAnswersNum + 1;
                  },
                  child: const Icon(Icons.add)),
              _deleteButton(context)
            ],
          ),
          alignment: Alignment.topLeft,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: createViewModel.inputAnswersNum,
                itemBuilder: (context, index) {
                  return _answerList(context, index);
                })),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: OutlinedButton(
                onPressed: () {
                  createViewModel.allClear();
                },
                child: const Text("Cancel"),
                style: OutlinedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ElevatedButton(
                  onPressed: () {
                    if (createViewModel.inputAnswers != [""] &&
                        createViewModel.inputQuestion != "" &&
                        createViewModel.inputCategory != "") {
                      instractsStore.addInstract(
                          createViewModel.inputCategory,
                          Instract(createViewModel.inputQuestion,
                              createViewModel.inputAnswers));
                      createViewModel.allClear();
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return AlertDialog(
                            content: const Text("Please Input All Instract"),
                            actions: [
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () => {
                                  Navigator.pop(context),
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text("Submit")),
            )
          ],
        ),
      ),
    );
  }

  Widget _answerList(BuildContext context, int index) {
    final CreateViewModel createViewModel =
        Provider.of<CreateViewModel>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListTile(
          title: TextField(
        maxLength: 30,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter a Answer',
        ),
        onChanged: (text) {
          createViewModel.updateAnswer(index, text);
        },
      )),
    );
  }

  // Answersをdeleteするボタン
  Widget _deleteButton(BuildContext context) {
    final CreateViewModel createViewModel =
        Provider.of<CreateViewModel>(context);
    if (createViewModel.inputAnswersNum > 1) {
      return TextButton(
          onPressed: () {
            createViewModel.inputAnswersNum =
                createViewModel.inputAnswersNum - 1;
            createViewModel.deleteAnswer();
          },
          child: const Icon(Icons.delete));
    } else {
      return Container();
    }
  }
}
