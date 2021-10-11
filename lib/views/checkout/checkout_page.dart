import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_list/controllers/home_controller.dart';
import 'package:product_list/models/cart_model.dart';
import 'package:product_list/models/product_model.dart';
import 'package:product_list/shared/widgets/buttons/primary_button.dart';
import 'package:product_list/shared/widgets/buttons/secondary_button.dart';
import 'package:product_list/shared/widgets/text/title_text.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    log('Checkout page - CartList: ' + cart.cartList.toString());
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
        ),
        title: PROTitleText(text: 'Carrinho', sizeH: 1, color: Colors.white,),
      ),

      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: cart.cartList.length,
        itemBuilder: (BuildContext context, int index) =>
            Card(
              child: ListTile(
                title: Text(cart.cartList[index]['product'].title),
              ),
            )
      ),

      persistentFooterButtons: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: PROSecondaryElevatedButton(
              label: 'Confirmar Compra',
              onPressed: () {},
            )
          ),
        ),
      ],
    );
  }
}
