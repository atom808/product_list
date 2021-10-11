import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_list/models/cart_model.dart';
import 'package:product_list/models/catalog_model.dart';
import 'package:product_list/views/auth/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => CatalogModel()),
      ],
      child: MaterialApp(
        title: 'FruitApp',
        theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.green.shade100,
          cardColor: Colors.green.shade50,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green,
            secondary: Colors.orange,
          ),
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
