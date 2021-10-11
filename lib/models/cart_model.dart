import 'dart:developer';

import 'package:flutter/material.dart';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  final List<Map> cartList = [];


  void addToCart(Product product) {
    if(cartList.where((element) => element['product'] == product).isNotEmpty) {
      cartList.where(
              (element) => element['product'] == product)
          .single.update('quantity', (value) => value = value + 1);
      log('CART LIST WHERE: ' + cartList.where(
              (element) => element['product'] == product).single.toString());
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


  void removeFromCart(Product product) {
    if(cartList.where((element) => element['product'] == product).single['quantity'] > 1) {
      cartList.where(
              (element) => element['product'] == product)
          .single.update('quantity', (value) => value = value - 1);
      log('CART LIST WHERE: ' + cartList.where(
              (element) => element['product'] == product).single.toString());
    } else {
      cartList.remove(
          cartList.where((element) => element['product'] == product).single,
      );
    }
    notifyListeners();
  }

}