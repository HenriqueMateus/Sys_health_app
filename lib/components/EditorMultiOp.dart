import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'padding_label_with_widget.dart';

class EditorMultiOp extends StatelessWidget {

  final Widget label;
  final String value;
  final List<String> options;
  final ValueChanged<String?>? onChanged;
  EditorMultiOp({required this.label, required this.value, required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {

    return PaddingLabelWithWidget(
      textPadding: EdgeInsets.only(left: 19, top: 20, right: 10),
      label:  Text(""),
      child: DropdownButton<String>(
        value: this.value,
        icon: Icon(Icons.arrow_downward, size: 20),
        hint: Text("-- selecione --"),
        iconSize: 25,
        elevation: 5,
        style: TextStyle(
            fontSize: 20,
            color: Colors.black
        ),
        underline: Container( height: 0 ),
        onChanged: onChanged,
        items: this.options.map<DropdownMenuItem<String>>((String value) =>
            DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            )
        ).toList(),
      ),
    );
  }

}