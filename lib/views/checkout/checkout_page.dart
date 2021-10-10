import 'package:flutter/material.dart';
import 'package:product_list/shared/widgets/buttons/primary_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Expanded(
          child: PROPrimaryElevatedButton(
            label: 'Confirmar Compra',
            onPressed: () {},
          )
        ),
      ],
    );
  }
}
