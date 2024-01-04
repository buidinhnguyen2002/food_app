class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageSource;
  final String restaurantId;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageSource,
    required this.restaurantId,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'].toString(),
      title: json['food_name'] as String,
      price: double.parse(json['price'].toString()),
      quantity: int.parse(json['quantity'].toString()),
      imageSource: json['image_source'] as String,
      restaurantId: json['restaurant_id'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
