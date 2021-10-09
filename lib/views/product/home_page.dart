import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_list/controllers/home_controller.dart';
import 'package:product_list/shared/widgets/inputs/text_input.dart';
import 'package:product_list/shared/widgets/text/title_text.dart';

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
            expandedHeight: 160,
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
                padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 30),
                child: PROTextInput(
                  label: 'Pesquisar',
                  controller: searchController,
                  icon: Icons.search,
                ),
              ),
              centerTitle: true,
              title: PROTitleText(
                text: 'FruitApp',
                color: Colors.white,
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
}
