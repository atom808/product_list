import 'package:flutter/material.dart';
import 'package:product_list/views/start_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.blueGrey.shade200,
        cardColor: Colors.blueGrey.shade50,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green,
          secondary: Colors.orange,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const StartPage(),
    );
  }
}
