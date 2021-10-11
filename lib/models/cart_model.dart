import 'dart:developer';

import 'package:flutter/material.dart';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  final List<Map> cartList = [];


  double totalPricePerProduct(int index) => cartList[index]['product'].price * cartList[index]['quantity'].toDouble();

  List<double> totalPriceListPerProduct() {
    List<double> prices = [];
    for (var element in cartList) {
      prices.add(element['product'].price * element['quantity'].toDouble());
    }
    return prices;
  }

  double totalPrice () {
    return totalPriceListPerProduct().fold(0, (previous, current) => previous + current);
  }

  int totalLength () {
    List<int> items = [];
    for (var element in cartList) {
      items.add(element['quantity']);
    }
    return items.fold(0, (previousValue, element) => previousValue + element);
  }

  void addToCart(Product product) {
    if(cartList.where((element) => element['product'] == product).isNotEmpty) {
      cartList.where(
              (element) => element['product'] == product)
          .single.update('quantity', (value) => value = value + 1);
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
    } else {
      cartList.remove(
          cartList.where((element) => element['product'] == product).single,
      );
    }
    notifyListeners();
  }

  void buy() {
    cartList.clear();
    notifyListeners();
  }

}