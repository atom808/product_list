import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_list/shared/widgets/buttons/primary_button.dart';
import 'package:product_list/shared/widgets/buttons/secondary_button.dart';
import 'package:product_list/shared/widgets/buttons/text_button.dart';
import 'package:product_list/shared/widgets/inputs/password_input.dart';
import 'package:product_list/shared/widgets/inputs/text_input.dart';
import 'package:product_list/shared/widgets/text/title_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Color(0xFF2E7D32)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 70, 20, 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: PROTitleText(
                    text: 'Cadastro',
                    color: Colors.white,
                  )),
            ),
            Spacer(),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  // key: registerFormKey,
                  child: Column(
                    children: [
                      Container(
                        child: PROTextInput(
                          label: 'Email',
                          controller: _emailController,
                          icon: Icons.email,
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 8,
                      ),
                      PROPasswordInput(
                        label: 'Senha',
                        controller: _passwordController,
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        child: PROPrimaryElevatedButton(
                          label: 'Cadastrar',
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     CupertinoPageRoute(
                            //         builder: (context) => LoginPage()
                            //     )
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.transparent,
              height: 180,
            )
          ],
        ),
      ),
    );
  }
}
