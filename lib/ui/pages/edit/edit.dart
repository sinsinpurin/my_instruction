import 'package:flutter/material.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/ui/components/instract_form.dart';
import 'package:my_instruction/viewmodel/create/create_view_model.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key, required this.instract, required this.category})
      : super(key: key);

  final Instract instract;
  final String category;

  @override
  Widget build(BuildContext context) {
    final CreateViewModel createViewModel =
        Provider.of<CreateViewModel>(context);
    final Instracts instractsStore = Provider.of<Instracts>(context);

    return InstractForm(
      mode: Mode.edit,
      createViewModel: createViewModel,
      instractsStore: instractsStore,
      editInstract: instract,
      category: category,
    );
  }
}
