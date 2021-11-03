import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/viewmodel/create/create_view_model.dart';
import 'package:my_instruction/util/initializer.dart';

class InstractForm extends StatelessWidget {
  const InstractForm(
      {Key? key,
      required this.mode,
      required this.createViewModel,
      required this.instractsStore,
      this.editInstract})
      : super(key: key);

  final Mode mode;
  final CreateViewModel createViewModel;
  final InstractsStore instractsStore;
  final Instract? editInstract;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> categoryList = [
      const DropdownMenuItem(child: Text("Select Category"), value: "")
    ];
    categoryList
        .add(const DropdownMenuItem(child: Text("New Category"), value: "new"));
    for (var item in instractsStore.categoryList) {
      categoryList.add(DropdownMenuItem(
          child: Text(item.category), value: item.categoryId.toString()));
    }

    return InitializerWrapper(
        onInit: () {
          if (editInstract != null) {
            // Edit時の初期値を読み込む
            Future(() {
              createViewModel.loadInstract(editInstract!.id, instractsStore);
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
                // DropDownButton カテゴリー選択ボタン
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
                  // カテゴリーにnewを選択した場合に新しいカテゴリーのテキストボックスを作成する
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
                // Questionのテキストボックス
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
                  // Answerのテキストボックスを追加するボタン
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
                  // Cancelボタン。全ての入力を消す
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
                    // Submitボタン
                    child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        switch (mode) {
                          case Mode.create:
                            if (createViewModel.inputAnswers != [""] &&
                                createViewModel.inputQuestion != "" &&
                                createViewModel.inputCategory != "") {
                              if (createViewModel.inputCategory == "new") {
                                // 新しいカテゴリーの場合
                                // TODO: ここCategoryId()どうにかする
                                instractsStore.addCategory(
                                    createViewModel.inputNewCategory);
                                instractsStore.addInstract(
                                    instractsStore.getLatestCategoryId(),
                                    createViewModel.inputQuestion,
                                    createViewModel.inputAnswers);
                              } else {
                                // 既存のカテゴリーの場合
                                instractsStore.addInstract(
                                    int.parse(createViewModel.inputCategory),
                                    createViewModel.inputQuestion,
                                    createViewModel.inputAnswers);
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
                              // TODO: update instract
                              instractsStore.updateInstract(
                                  editInstract!.id,
                                  int.parse(createViewModel.inputCategory),
                                  createViewModel.inputQuestion,
                                  createViewModel.inputAnswers);
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
                    ))
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
