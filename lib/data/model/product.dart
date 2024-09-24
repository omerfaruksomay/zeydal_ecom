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
      id: json['_id'] as String? ?? '',  // Eğer 'id' null gelirse, boş string döndür
      uuid: json['uuid'] as String? ?? '',
      name: json['name'] as String? ?? 'Unnamed Product',
      definition: json['definition'] as String? ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : [],  // Eğer 'images' null ise boş liste döndür
      categories: json['categories'] != null
          ? List<String>.from(json['categories'] as List)
          : [],  // Eğer 'categories' null ise boş liste döndür
      brand: json['brand'] as String? ?? 'Unknown Brand',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,  // Eğer 'price' null ise 0.0 döndür
      currency: json['currency'] as String? ?? 'Unknown Currency',
      stock: json['stock'] as int? ?? 0,  // Eğer 'stock' null ise 0 döndür
      itemType: json['itemType'] as String? ?? 'Unknown Type',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),  // Eğer 'createdAt' null ise şu anki zamanı döndür
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),  // Eğer 'updatedAt' null ise şu anki zamanı döndür
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
