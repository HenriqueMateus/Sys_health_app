import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaddingLabelWithWidget extends StatelessWidget {

  final Widget label;
  final Widget child;
  final EdgeInsetsGeometry textPadding;
  PaddingLabelWithWidget({required this.label, required this.child, this.textPadding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: this.label
          ),
          this.child
        ]);
  }

}