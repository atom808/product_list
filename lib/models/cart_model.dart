import 'package:flutter/material.dart';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  final List<Map> cartList = [];


  void addToCart(Product product) {
    if(cartList.where((element) => element['product'] == product).isNotEmpty) {
      cartList.where(
              (element) => element['product'] == product)
          .single.update('quantity', (value) => value++);
    } else {
      cartList.add(
        {
          'quantity': 1,
          'product': product
        }
      );
    }
    notifyListeners();
  }

}