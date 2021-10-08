import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_list/shared/widgets/buttons/primary_button.dart';
import 'package:product_list/shared/widgets/buttons/secondary_button.dart';
import 'package:product_list/shared/widgets/buttons/text_button.dart';
import 'package:product_list/shared/widgets/inputs/password_input.dart';
import 'package:product_list/shared/widgets/inputs/text_input.dart';
import 'package:product_list/shared/widgets/text/title_text.dart';
import 'package:product_list/views/auth/register_page.dart';
import 'package:product_list/views/product/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  authHandler() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
    } on FirebaseAuthException catch  (e) {
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: Text('Atenção'),
        content: Text(e.message.toString()),
        actions: [
          PROTextButton(label: 'OK', onPressed: () {Navigator.pop(context);},)
        ],
      ));
    }
  }

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
                    text: 'FruitApp',
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
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      Container(
                        child: PROTextInput(
                          label: 'Email',
                          controller: emailController,
                          icon: Icons.email,
                          emptyText: 'Campo obrigatório',
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 8,
                      ),
                      PROPasswordInput(
                        label: 'Senha',
                        controller: passwordController,
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        child: PROSecondaryElevatedButton(
                          label: 'Entrar',
                          onPressed: () {
                            if(_loginFormKey.currentState!.validate()) {
                              authHandler();
                            }
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: PROTextButton(
                          label: 'Cadastrar',
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (_) => RegisterPage()));
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
