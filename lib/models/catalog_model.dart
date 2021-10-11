import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'product_model.dart';

class CatalogModel extends ChangeNotifier{
  List<Product> productListShow = List.empty(growable: true);
  List<Product> productListFromServer = List.empty(growable: true);

  Future<List<Product>> getProducts() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('products').get();

    productListShow.clear();
    productListFromServer.clear();

    log('SEARCH - productListShow from server: ' + productListShow.toString());

    for (var doc in querySnapshot.docs) {
      Product product = Product.fromJson(doc.data(), doc.id);
      productListFromServer.add(product);
    }


    log('SEARCH - productList from server: ' + productListShow.toString());

    if(tempList.isNotEmpty) {
      productListShow.clear();

      productListShow.addAll(tempList.toSet());
    } else {
      productListShow.clear();
      productListShow.addAll(productListFromServer);
    }



    return productListShow;
  }

  List<Product> tempList = [];

  search(String text) {

    tempList.clear();

    log('SEARCH - text: ' + text.toString());

    for (var element in productListShow) {
      if (element.title.toString().toLowerCase().contains(text.toLowerCase())) {
        if(tempList.contains(element) == false) {
          tempList.add(element);
          log('SEARCH - element title: ' + element.title.toString());
        }
      } else {
        if(tempList.contains(element)) {
          tempList.remove(element);
          log('SEARCH - removeu: ');
        }
      }
    }

    if(text == '') {
      tempList.clear();
    }
    productListShow.clear();
    productListShow.addAll(tempList.toSet());

    log('SEARCH - TEMPLIST: ' + tempList.toString());
    log('SEARCH - productListShow: ' + productListShow.toString());
    notifyListeners();
    log('SEARCH - productListShow after: ' + productListShow.toString());
  }
}