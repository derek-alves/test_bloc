import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final int index;
  final Function onUpdate;

  const InputWidget({
    Key? key,
    required this.index,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("ID: ${index + 1}"),
        const SizedBox(
          width: 10,
        ),
        Flexible(
            child: TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            onUpdate(index, value);
          },
        ))
      ],
    );
  }
}
