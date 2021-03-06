import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/viewmodel/create/create_view_model.dart';
import 'package:my_instruction/util/initializer.dart';
import 'package:my_instruction/viewmodel/create/instract_view_model.dart';

class InstractForm extends StatelessWidget {
  const InstractForm(
      {Key? key,
      required this.mode,
      required this.instractViewModel,
      required this.createViewModel,
      required this.instractsStore,
      this.editInstract})
      : super(key: key);

  final Mode mode;
  final InstractViewModel instractViewModel;
  final CreateViewModel createViewModel;
  final InstractsStore instractsStore;
  final Instract? editInstract;

  @override
  Widget build(BuildContext context) {
    return InitializerWrapper(
        onInit: () {
          if (editInstract != null) {
            // Edit時の初期値を読み込む
            Future(() async {
              await createViewModel.loadInstract(
                  editInstract!.id, instractsStore, Mode.edit);
            });
          }
          Future(() async {
            await instractsStore.refleshCategoryList();
          });
        },
        child: Scaffold(
          appBar: AppBar(
            title: () {
              switch (mode) {
                case Mode.create:
                  return const Text("Q&A 作成");
                case Mode.edit:
                  return const Text("Q&A 編集");
              }
            }(),
            actions: [
              () {
                switch (mode) {
                  case Mode.create:
                    return const SizedBox.shrink();
                  case Mode.edit:
                    return IconButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text("この説明を削除しますか？"),
                                  actions: [
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("キャンセル")),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await instractsStore.deleteInstract(
                                              editInstract!.id,
                                              editInstract!.categoryId);
                                          createViewModel.allClear();
                                          Navigator.popUntil(context,
                                              ModalRoute.withName("/"));
                                        },
                                        child: const Text("はい"))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.delete));
                }
              }(),
            ],
          ),
          body: Column(children: [
            Container(
              padding: const EdgeInsets.only(left: 30, top: 100),
              child: const Text("カテゴリー", style: TextStyle(fontSize: 20)),
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
                  value: createViewModel.inputCategory,
                  onChanged: (category) {
                    if (category != "" && category != null) {
                      createViewModel.inputCategory = category;
                    }
                  },
                  style: const TextStyle(color: Colors.black),
                  items: instractsStore
                      .getDropDownButtonCatgoryList()
                      .map<DropdownMenuItem<String>>((Category category) {
                    return DropdownMenuItem<String>(
                      // value: category.categoryId.toString(),
                      value: category.category,
                      child: Text(category.category),
                    );
                  }).toList(),
                );
              }(),
              alignment: Alignment.topLeft,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 15),
                child: (() {
                  // カテゴリーにnewを選択した場合に新しいカテゴリーのテキストボックスを作成する
                  if (createViewModel.inputCategory == "新しいカテゴリ") {
                    return TextFormField(
                      maxLength: 30,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '新しいカテゴリーを入力',
                      ),
                      onChanged: (text) {
                        createViewModel.inputNewCategory = text;
                      },
                    );
                  } else {}
                }())),
            Container(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: const Text("質問", style: TextStyle(fontSize: 20)),
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
                    hintText: '質問を入力',
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
                  const Text("答え", style: TextStyle(fontSize: 20)),
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
                      Navigator.of(context).pop();
                      createViewModel.allClear();
                    },
                    child: const Text("キャンセル"),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20),
                    // Submitボタン
                    child: ElevatedButton(
                      child: const Text("保存"),
                      onPressed: () async {
                        switch (mode) {
                          case Mode.create:
                            if (createViewModel.inputAnswers != [""] &&
                                createViewModel.inputQuestion != "" &&
                                createViewModel.inputCategory != "") {
                              if (createViewModel.inputCategory == "新しいカテゴリ") {
                                // 新しいカテゴリーの場合
                                await instractsStore.addCategory(
                                    createViewModel.inputNewCategory);
                                int newCategoryId =
                                    await instractsStore.getIdByCategory(
                                        createViewModel.inputNewCategory);
                                await instractsStore.addInstract(
                                    newCategoryId,
                                    createViewModel.inputQuestion,
                                    createViewModel.inputAnswers);
                              } else {
                                // 既存のカテゴリーの場合
                                int categoryId =
                                    await instractsStore.getIdByCategory(
                                        createViewModel.inputCategory);
                                await instractsStore.addInstract(
                                    categoryId,
                                    createViewModel.inputQuestion,
                                    createViewModel.inputAnswers);
                              }
                              createViewModel.allClear();
                              Navigator.of(context).pop();
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return AlertDialog(
                                    content: const Text("空の入力欄があります"),
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
                                createViewModel.inputCategory != "" &&
                                editInstract != null) {
                              await instractsStore.updateInstract(
                                  editInstract!.id,
                                  editInstract!.categoryId,
                                  createViewModel.inputQuestion,
                                  createViewModel.inputAnswers);
                              instractViewModel
                                  .loadCategory(editInstract!.categoryId);
                              instractViewModel.loadInstract(editInstract!.id);
                              createViewModel.allClear();
                              Navigator.pop(context);
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return AlertDialog(
                                    content: const Text("空の入力欄があります"),
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
          hintText: '答えを入力',
        ),
        initialValue: () {
          if (editInstract == null) {
            return "";
          } else {
            if (editInstract!.answers.length <= index) {
              return "";
            }
            return editInstract!.answers[index];
          }
        }(),
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
            createViewModel.deleteAnswer();
          },
          child: const Icon(Icons.delete));
    } else {
      return const SizedBox.shrink();
    }
  }
}
