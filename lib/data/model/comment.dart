class Comment {
  String id;
  String productId;
  String userId;
  int rating;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });
}
