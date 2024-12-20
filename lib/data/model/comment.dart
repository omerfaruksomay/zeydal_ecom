import 'package:intl/intl.dart';

class Comment {
  String id;
  String productId;
  int rating;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    required this.id,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      // userId artık Map<String, dynamic>
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get formattedCreatedAt {
    return DateFormat('dd/MM/yyyy')
        .format(createdAt); // "21/03/2024" formatında döner
  }

  String get formattedUpdatedAt {
    return DateFormat('dd/MM/yyyy')
        .format(updatedAt); // "21/03/2024" formatında döner
  }
}
