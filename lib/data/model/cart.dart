import 'package:zeydal_ecom/data/model/product.dart';

class Cart {
  final String id;
  final String uuid;
  final bool completed;
  final String buyer;
  final List<Product> products;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cart({
    required this.id,
    required this.uuid,
    required this.completed,
    required this.buyer,
    required this.products,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON'dan Cart nesnesine dönüştürme fonksiyonu
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['_id'],
      uuid: json['uuid'],
      completed: json['completed'],
      buyer: json['buyer'],
      products: (json['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
      currency: json['currency'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
