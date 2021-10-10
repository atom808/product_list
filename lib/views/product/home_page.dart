import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_list/controllers/home_controller.dart';
import 'package:product_list/shared/widgets/inputs/text_input.dart';
import 'package:product_list/shared/widgets/text/title_text.dart';
import 'package:product_list/views/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        ),
                      ),
                    ),
                    VerticalDivider(width: 8,),
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.2)
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_basket, color: Colors.white,),
                      ),
                    ),
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
              future: HomeController().productList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  log('Snapshot: ' + snapshot.toString());
                  return SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2/3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: HomeController().productListWidgets(snapshot.data),
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
