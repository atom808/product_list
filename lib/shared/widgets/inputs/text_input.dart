import 'package:flutter/material.dart';
import 'decoration/input_decoration.dart';

class PROTextInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;

  const PROTextInput(
      {Key? key, required this.label, required this.controller, this.icon})
      : super(key: key);

  @override
  _PROTextInputState createState() => _PROTextInputState();
}

class _PROTextInputState extends State<PROTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: PROInputDecoration().textInputDecoration(
        label: widget.label,
        icon: widget.icon,
      ),
    );
  }
}
