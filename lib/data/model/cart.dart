  import 'package:intl/intl.dart';

class Cart {
    final String id;
    final String uuid;
    final bool completed;
    final String buyer;
    final List<Map<String, dynamic>> products; // Her bir ürün Map olarak tutuluyor
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

    factory Cart.fromJson(Map<String, dynamic> json) {
      return Cart(
        id: json['_id'],
        uuid: json['uuid'],
        completed: json['completed'],
        buyer: json['buyer'],
        products: List<Map<String, dynamic>>.from(json['products']),
        currency: json['currency'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );
    }


    String get formattedCreatedAt {
      return DateFormat('dd/MM/yyyy').format(createdAt);  // "21/03/2024" formatında döner
    }

    String get formattedUpdatedAt {
      return DateFormat('dd/MM/yyyy').format(updatedAt);  // "21/03/2024" formatında döner
    }


  }
