import 'dart:developer';

class Product {
  final String id;
  final String title;
  final double price;
  final int? quantity;
  final String? imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });


  static Product fromJson(dynamic json, String id) => Product(
    title: json['title'],
    price: json['price'],
    id: id,
    imageUrl: json['imageUrl'],
    quantity: 0,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'price': price,
    'id': id,
    'imageUrl': imageUrl,
    'quantity': quantity,
  };

}