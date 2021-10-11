import 'dart:developer';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'product_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'dart:io' as io;

class CartModel extends ChangeNotifier {
  final List<Map> cartList = [];


  double totalPricePerProduct(int index) => cartList[index]['product'].price * cartList[index]['quantity'].toDouble();

  List<double> totalPriceListPerProduct() {
    List<double> prices = [];
    for (var element in cartList) {
      prices.add(element['product'].price * element['quantity'].toDouble());
    }
    return prices;
  }

  double totalPrice() {
    return totalPriceListPerProduct().fold(0, (previous, current) => previous + current);
  }

  int totalLength() {
    List<int> items = [];
    for (var element in cartList) {
      items.add(element['quantity']);
    }
    return items.fold(0, (previousValue, element) => previousValue + element);
  }

  void addToCart(Product product) {
    if(cartList.where((element) => element['product'] == product).isNotEmpty) {
      cartList.where(
              (element) => element['product'] == product)
          .single.update('quantity', (value) => value = value + 1);
    } else {
      cartList.add(
        {
          'quantity': 1,
          'product': product
        }
      );
    }
    notifyListeners();
  }


  void removeFromCart(Product product) {
    if(cartList.where((element) => element['product'] == product).single['quantity'] > 1) {
      cartList.where(
              (element) => element['product'] == product)
          .single.update('quantity', (value) => value = value - 1);
    } else {
      cartList.remove(
          cartList.where((element) => element['product'] == product).single,
      );
    }
    notifyListeners();
  }


  void buy() {
    createPdf()
        .then((value) => cartList.clear())
        .then((value) => notifyListeners());
  }

  Future<void> createPdf() async {
    final pdf = pw.Document();

    List<pw.Widget> getListViewChildren() {
      List<pw.Widget> listWidget = [];
      for (var element in cartList) {
        listWidget.add(pw.Container(
            margin: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: pw.Column(
                children: [
                  pw.Text(element['product'].title, style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold
                  )),
                  pw.Text(element['product'].price.toString()),
                  pw.Text(element['product'].price.toString()),
                ]
            )
        ));
      }
      return listWidget;
    }

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Text('Comprovante - FruitApp'),
              pw.Divider(),
              // pw.ListView(
              //   children: getListViewChildren(),
              // ),
              pw.Divider(),
              pw.Text('Total: R\$ ' + totalPrice().toStringAsFixed(2)),
            ]
          ),
        ),
      ),
    );

    savePdf(pdf);
  }


  Future<void> savePdf(var pdf) async{
    String path = (await getApplicationDocumentsDirectory()).path;

    final file = File("$path/comprovante.pdf");

    await file.writeAsBytes(await pdf.save()).then((value) => OpenFile.open('$path/comprovante.pdf'));
  }

}