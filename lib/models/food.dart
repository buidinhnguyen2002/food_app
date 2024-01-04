class Food {
  final String id;
  final String restaurantId;
  final String foodName;
  final String description;
  final double price;
  final String unit;
  final int rate;
  final String imageSource;
  final String date;
  final int quantityInit;
  final int quantityAvailable;

  Food({
    required this.id,
    required this.restaurantId,
    required this.foodName,
    required this.description,
    required this.price,
    required this.unit,
    required this.rate,
    required this.imageSource,
    required this.date,
    required this.quantityInit,
    required this.quantityAvailable,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      foodName: json['food_name'],
      description: json['description'],
      price: double.parse(json['price']),
      unit: json['unit'],
      rate: int.parse(json['rate']),
      imageSource: json['image_source'],
      date: json['date'],
      quantityInit: int.parse(json['quantity_init']),
      quantityAvailable: int.parse(json['quantity_available']),
    );
  }
}
