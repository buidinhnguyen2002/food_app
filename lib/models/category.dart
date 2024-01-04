class Category {
  final String id;
  final String name;
  final String imageSource;
  Category({
    required this.id,
    required this.name,
    required this.imageSource,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? "" as String,
      name: json['name'] as String,
      imageSource: json['image_category'] as String,
    );
  }
}
