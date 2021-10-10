import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:product_list/models/product_model.dart';
import 'package:product_list/shared/widgets/text/title_text.dart';

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
          elevation: 12,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: InkWell(
            onTap: () {},
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 4/5,
                      child: SizedBox(
                        width: double.infinity,
                        child: element.imageUrl!.length > 3
                            ? Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(element.imageUrl!),
                                  Container(
                                      height: 30,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.grey.shade400.withOpacity(0),
                                              Colors.grey.shade400.withOpacity(0.1),
                                              Colors.grey.shade800.withOpacity(0.8),
                                          ])
                                      )
                                  ),

                                  Positioned(
                                    bottom: 4,
                                      left: 6,
                                      child: Container(
                                        margin: EdgeInsets.all(8),
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: PROTitleText(
                                          text: 'R\$ ' + element.price.toString(),
                                          color: Colors.grey.shade800,
                                          sizeH: 3,
                                        ),
                                      )
                                  ),
                                ],
                              )
                            : Container(
                              width: double.infinity,
                              color: Colors.grey,
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_rounded, size: 40, color: Colors.white,
                                ),
                              ),
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        PROTitleText(text: element.title, sizeH: 3, color: Colors.grey.shade800,)
                      ],
                    ),
                  )
                ],
              )
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


  Stream<List<Product>> cartList = Stream.empty();

}