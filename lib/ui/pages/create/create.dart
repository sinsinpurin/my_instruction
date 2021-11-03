import 'package:flutter/material.dart';
import 'package:my_instruction/ui/components/instract_form.dart';
import 'package:my_instruction/viewmodel/create/create_view_model.dart';
import 'package:my_instruction/model/instract.dart';
import 'package:my_instruction/viewmodel/create/instract_view_model.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateViewModel createViewModel =
        Provider.of<CreateViewModel>(context);
    final InstractsStore instractsStore = Provider.of<InstractsStore>(context);
    final InstractViewModel instractViewModel =
        Provider.of<InstractViewModel>(context);

    return InstractForm(
        mode: Mode.create,
        instractViewModel: instractViewModel,
        createViewModel: createViewModel,
        instractsStore: instractsStore);
  }
}
