import 'package:flutter/material.dart';
import 'package:product_list/models/cart_model.dart';
import 'package:provider/provider.dart';

class QuantityButton extends StatefulWidget {
  final int index;
  const QuantityButton({Key? key, required this.index}) : super(key: key);

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Container(
      width: 100,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        )
      ),
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              cart.removeFromCart(cart.cartList[widget.index]['product']);
            },
            icon: Icon(Icons.remove, color: Colors.redAccent, size: 20,),
          ),
          Text(
              cart.cartList[widget.index]['quantity'].toString(),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              cart.addToCart(cart.cartList[widget.index]['product']);
            },
            icon: Icon(Icons.add, color: Colors.green, size: 20,),
          ),
        ],
      ),
    );
  }
}
