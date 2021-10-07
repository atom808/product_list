import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_list/shared/widgets/buttons/primary_button.dart';
import 'package:product_list/shared/widgets/buttons/secondary_button.dart';
import 'package:product_list/shared/widgets/buttons/text_button.dart';
import 'package:product_list/shared/widgets/text/pro_main_title_text_widget.dart';
import 'package:product_list/views/login_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green,
            Color(0xFF2E7D32)
          ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 70, 20, 20),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: PROMainTitleTextWidget(text: 'Vamos Começar!')),
            ),
            Spacer(),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.green.shade800,
                radius: 80,
                child: Center(
                  child: Text('Logo'),
                ),
              ),
            ),
            Spacer(),
            PROSecondaryElevatedButton(
              label: 'Quero me cadastrar!',
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => LoginPage()
                  )
                );
              },
            ),
            PROTextButton(
              label: 'Já tenho conta',
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => LoginPage()
                    )
                );
              },
            ),
            Divider(color: Colors.transparent, height: 100,)
          ],
        ),
      ),
    );
  }
}
