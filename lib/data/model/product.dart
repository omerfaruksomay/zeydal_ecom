class Product {
  final String id;
  final String uuid;
  final String name;
  final String definition;
  final List<String> images;
  final List<String> categories;
  final Map<String, dynamic> seller;
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
    required this.seller,
    required this.price,
    required this.currency,
    required this.stock,
    required this.itemType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      uuid: json['uuid'],
      name: json['name'],
      definition: json['definition'],
      images: List<String>.from(json['images']),
      categories: List<String>.from(json['categories']),
      seller: Map<String, dynamic>.from(json['seller']),
      price: json['price'].toDouble(),
      currency: json['currency'],
      stock: json['stock'],
      itemType: json['itemType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
