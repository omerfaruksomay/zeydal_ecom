class Product {
  final String id;
  final String uuid;
  final String name;
  final String definition;
  final List<String> images;
  final List<String> categories;
  final String brand;
  final double price;
  final String currency;
  final int stock;
  final String itemType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.uuid,
    required this.name,
    required this.definition,
    required this.images,
    required this.categories,
    required this.brand,
    required this.price,
    required this.currency,
    required this.stock,
    required this.itemType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String,
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      definition: json['definition'] as String,
      images: List<String>.from(json['images'] as List),
      categories: List<String>.from(json['categories'] as List),
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      stock: json['stock'] as int,
      itemType: json['itemType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'uuid': uuid,
      'name': name,
      'definition': definition,
      'images': images,
      'categories': categories,
      'brand': brand,
      'price': price,
      'currency': currency,
      'stock': stock,
      'itemType': itemType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
