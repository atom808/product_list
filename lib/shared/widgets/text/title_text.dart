import 'package:flutter/material.dart';

class PROTitleText extends StatefulWidget {
  final String text;
  final Color color;
  const PROTitleText({
    Key? key,
    required this.text,
    this.color = Colors.black87
  }) : super(key: key);

  @override
  _PROTitleTextState createState() => _PROTitleTextState();
}

class _PROTitleTextState extends State<PROTitleText> {

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: widget.color,
        fontWeight: FontWeight.bold,
        fontSize: 30
      ),
    );
  }
}
