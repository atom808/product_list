import 'package:flutter/material.dart';
import 'package:product_list/shared/widgets/buttons/primary_button.dart';
import 'package:product_list/shared/widgets/text/pro_main_title_text_widget.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: PROMainTitleTextWidget(text: 'Login')),
          ),
          Spacer(),
          PROPrimaryElevatedButton(
            label: 'Entrar',
            onPressed: () {
              // Navigator.push(
              //     context,
              //     CupertinoPageRoute(
              //         builder: (context) => LoginPage()
              //     )
              // );
            },
          ),
          Divider(color: Colors.transparent, height: 100,)
        ],
      ),
    );
  }
}
