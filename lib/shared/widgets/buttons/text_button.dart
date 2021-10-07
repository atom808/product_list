import 'package:flutter/material.dart';
import 'package:product_list/shared/widgets/buttons/decoration/button_decoration.dart';

class PROTextButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  const PROTextButton({Key? key, required this.label, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: PROButtonDecoration().textButton(),
      child: Text(label, style: TextStyle(color: Colors.white),),
    );
  }
}
