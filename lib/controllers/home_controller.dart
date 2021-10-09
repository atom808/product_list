import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:product_list/models/product_model.dart';

class HomeController {

  Future<List<Product>> productList() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('products').get();

    List<Product> productList = List.empty(growable: true);
    querySnapshot.docs.forEach((doc) {
      Product product = Product.fromJson(doc.data(), doc.id);
      productList.add(product);
    });

    return productList;
  }

  List<Widget> productListWidgets(List<Product> productList) {
    List<Widget> widgets = List.empty(growable: true);

    productList.forEach((element) {
      widgets.add(
        Card(
          key: Key(element.id),
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            width: double.infinity,
            child: Center(
              child: Text(element.title),
            ),
          ),
        ),
      );
    });

    if(widgets.length > 0) {
      return widgets;
    } else {
      return [];
    }
  }

}