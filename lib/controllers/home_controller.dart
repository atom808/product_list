import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:product_list/models/cart_model.dart';
import 'package:product_list/models/catalog_model.dart';
import 'package:product_list/models/product_model.dart';
import 'package:product_list/shared/widgets/text/title_text.dart';
import 'package:product_list/views/product/home_page.dart';
import 'package:provider/provider.dart';

class HomeController {



  List<Widget> productListWidgets(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);
    var catalog = context.watch<CatalogModel>();

    for (var element in catalog.productListShow) {
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
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PROTitleText(text: element.title, sizeH: 3, color: Colors.grey.shade800,),
                        InkWell(
                          onTap: () {
                            var cart = context.read<CartModel>();
                            cart.addToCart(element);
                            log('CART LIST PROVIDER: ' + cart.cartList.toString());
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.amber,
                            ),
                            child: Center(child: Icon(Icons.add, color: Colors.white, size: 20,)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
        ),
      );
    }

    if(widgets.length > 0) {
      return widgets;
    } else {
      return [];
    }
  }

}