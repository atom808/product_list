import 'package:flutter/material.dart';


class PROButtonDecoration {

  elevatedButton ({
    required Color color,
    Brightness brightness = Brightness.light
  }) {
    return ElevatedButton.styleFrom(
      primary: color,
      shape: StadiumBorder(),
      maximumSize: Size.fromWidth(400),
    );
  }


  textButton ({Brightness brightness = Brightness.light}) {
    return TextButton.styleFrom(
      shape: StadiumBorder(),
      maximumSize: Size.fromWidth(400),
      primary: Colors.orange
    );
  }
}