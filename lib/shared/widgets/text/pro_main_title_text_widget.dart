import 'package:flutter/material.dart';

class PROMainTitleTextWidget extends StatefulWidget {
  final String text;
  final Color color;
  const PROMainTitleTextWidget({Key? key, required this.text, this.color = Colors.black87}) : super(key: key);

  @override
  _PROMainTitleTextWidgetState createState() => _PROMainTitleTextWidgetState();
}

class _PROMainTitleTextWidgetState extends State<PROMainTitleTextWidget> {

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
