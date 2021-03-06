import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_list/controllers/home_controller.dart';
import 'package:product_list/models/cart_model.dart';
import 'package:product_list/models/catalog_model.dart';
import 'package:product_list/shared/widgets/inputs/text_input.dart';
import 'package:product_list/shared/widgets/text/title_text.dart';
import 'package:product_list/views/auth/login_page.dart';
import 'package:product_list/views/checkout/checkout_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var catalog = context.watch<CatalogModel>();
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            collapsedHeight: 60,
            expandedHeight: 140,
            elevation: 24,
            floating: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            iconTheme: IconThemeData(color: Colors.white,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
            snap: true,
            pinned: true,
            stretch: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.green,
                    Colors.green.shade900
                  ]),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: PROTextInput(
                          color: Colors.grey.shade100,
                          label: 'Pesquisar',
                          controller: searchController,
                          icon: Icons.search,
                          onChanged: (String text) {
                            catalog.search(text);
                          },
                        ),
                      ),
                    ),
                    VerticalDivider(width: 8,),
                    getCartButton(),
                    VerticalDivider(width: 8,),
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.2)
                      ),
                      child: IconButton(
                        onPressed: () {
                          getMenu();
                        },
                        icon: Icon(Icons.menu, color: Colors.white,),
                      ),
                    )
                  ],
                )
              ),
              titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              centerTitle: false,
              title: PROTitleText(
                text: 'FruitApp',
                color: Colors.white,
                sizeH: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: FutureBuilder(
              future: catalog.getProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  log('Snapshot: ' + snapshot.toString());
                  return SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2/3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: HomeController().productListWidgets(context),
                  );
                } else {
                  return SliverGrid.count(
                    crossAxisCount: 1,
                    children: const [
                      Center(
                        child: Text('CARREGANDO DADOS...'),
                      )
                    ],
                  );
                }
              }
            )
          )
        ],
      ),
    );
  }

  getCartButton() {
    var cart = context.watch<CartModel>();
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.2)
      ),
      child: Stack(
        children: [
          Center(
            child: IconButton(
              onPressed: cart.cartList.isNotEmpty ? () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => CheckoutPage(),
                  ),
                );
              } : null,
              icon: Icon(Icons.shopping_basket, color: cart.cartList.isNotEmpty ? Colors.white: Colors.grey.shade400

                ,),
            ),
          ),
          cart.cartList.isNotEmpty ? Positioned(
            right: 4,
            top: 10,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle
              ),
              child: Center(
                child: CartBadge()
              ),
            ),
          ) : Container(),
        ],
      )
    );
  }


  getMenu() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: PROTitleText(
          text: 'FruitApp',
          sizeH: 1,
        ),
        content: ListTile(
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) =>
                Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
                    builder: (_) => LoginPage()), (route) => false)
            );
          },
          title: Text('Fazer logout'),
          trailing: Icon(Icons.logout),
        ),
      )
    );
  }
}


class CartBadge extends StatefulWidget {
  const CartBadge({Key? key}) : super(key: key);

  @override
  _CartBadgeState createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Text(
      cart.totalLength().toString(),
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10
      ),
    );
  }
}

