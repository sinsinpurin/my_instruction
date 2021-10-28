import 'package:flutter/material.dart';
import 'package:flutter/scheduler.Dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/viewmodel/create/create_view_model.dart';
import 'package:my_instruction/util/initializer.dart';

class InstractForm extends StatelessWidget {
  const InstractForm(
      {Key? key,
      required this.mode,
      required this.createViewModel,
      required this.instractsStore,
      this.category,
      this.editInstract,
      this.instractNum})
      : super(key: key);

  final Mode mode;
  final CreateViewModel createViewModel;
  final Instracts instractsStore;
  final Instract? editInstract;
  final String? category;
  final int? instractNum;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> categoryList = [
      const DropdownMenuItem(child: Text("Select Category"), value: "")
    ];
    categoryList
        .add(const DropdownMenuItem(child: Text("New Category"), value: "new"));
    for (var key in instractsStore.instractsList.keys) {
      categoryList.add(DropdownMenuItem(child: Text(key), value: key));
    }

    return InitializerWrapper(
        onInit: () {
          if (editInstract != null && category != null) {
            Future(() {
              createViewModel.loadInstract(
                  category!, editInstract!.question, editInstract!.answers);
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: () {
              switch (mode) {
                case Mode.create:
                  return const Text("Create Q&A");
                case Mode.edit:
                  return const Text("Edit Q&A");
              }
            }(),
          ),
          body: Column(children: [
            Container(
              padding: const EdgeInsets.only(left: 30, top: 100),
              child: const Text("Category", style: TextStyle(fontSize: 20)),
              alignment: Alignment.topLeft,
            ),
            Container(
              padding: const EdgeInsets.only(left: 30),
              child: () {
                if (mode == Mode.edit) {
                  return Text(createViewModel.inputCategory);
                }
                return DropdownButton<String>(
                  items: categoryList,
                  value: createViewModel.inputCategory,
                  onChanged: (category) {
                    if (category != "" && category != null) {
                      createViewModel.inputCategory = category;
                    }
                  },
                );
              }(),
              alignment: Alignment.topLeft,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 15),
                child: (() {
                  if (createViewModel.inputCategory == "new") {
                    return TextFormField(
                      maxLength: 30,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a new Category',
                      ),
                      onChanged: (text) {
                        createViewModel.inputNewCategory = text;
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
                child: TextFormField(
                  maxLength: 30,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a Question',
                  ),
                  initialValue:
                      editInstract == null ? "" : editInstract!.question,
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
                        switch (mode) {
                          case Mode.create:
                            if (createViewModel.inputAnswers != [""] &&
                                createViewModel.inputQuestion != "" &&
                                createViewModel.inputCategory != "") {
                              if (createViewModel.inputCategory == "new") {
                                instractsStore.addInstract(
                                    createViewModel.inputNewCategory,
                                    Instract(createViewModel.inputQuestion,
                                        createViewModel.inputAnswers));
                              } else {
                                instractsStore.addInstract(
                                    createViewModel.inputCategory,
                                    Instract(createViewModel.inputQuestion,
                                        createViewModel.inputAnswers));
                              }
                              createViewModel.allClear();
                              Navigator.pop(context);
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return AlertDialog(
                                    content:
                                        const Text("Please Input All Instract"),
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
                            break;
                          case Mode.edit:
                            if (createViewModel.inputAnswers != [""] &&
                                createViewModel.inputQuestion != "" &&
                                createViewModel.inputCategory != "") {
                              Instract inst = Instract(
                                  createViewModel.inputCategory,
                                  createViewModel.inputAnswers);
                              //instractsStore.updateInstract(createViewModel.inputCategory, inst, instractNum)
                              createViewModel.allClear();
                              Navigator.pop(context);
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return AlertDialog(
                                    content:
                                        const Text("Please Input All Instract"),
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
                              break;
                            }
                        }
                      },
                      child: const Text("Submit")),
                )
              ],
            ),
          ),
        ));
  }

  Widget _answerList(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListTile(
          title: TextFormField(
        maxLength: 30,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter a Answer',
        ),
        initialValue: editInstract == null ? "" : editInstract!.answers[index],
        onChanged: (text) {
          createViewModel.updateAnswer(index, text);
        },
      )),
    );
  }

  // Answersをdeleteするボタン
  Widget _deleteButton(BuildContext context) {
    if (createViewModel.inputAnswersNum > 1) {
      return TextButton(
          onPressed: () {
            createViewModel.inputAnswersNum =
                createViewModel.inputAnswersNum - 1;
            print(createViewModel.inputAnswersNum);
            createViewModel.deleteAnswer();
          },
          child: const Icon(Icons.delete));
    } else {
      return Container();
    }
  }
}
