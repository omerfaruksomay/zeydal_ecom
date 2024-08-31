class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(String categoryName) {
    return Category(name: categoryName);
  }
}