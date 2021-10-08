class Product {
  final String title;
  final int price;
  final int quantity;
  final String? imageUrl;

  Product({
    required this.title,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });}