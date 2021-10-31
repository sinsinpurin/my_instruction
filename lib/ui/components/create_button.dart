import 'package:flutter/material.dart';
import 'package:my_instruction/ui/pages/create/create.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CreatePage(),
          ),
        );
      },
    );
  }
}
