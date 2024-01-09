class Review {
  final String id;
  final String fullNameCustomer;
  final String avatarCustomer;
  final String restaurantId;
  final String customerId;
  final double rate;
  final String message;
  final String createAt;

  Review({
    required this.id,
    required this.restaurantId,
    required this.customerId,
    required this.rate,
    required this.message,
    required this.createAt,
    required this.fullNameCustomer,
    required this.avatarCustomer,
  });
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'].toString(),
      fullNameCustomer: json['full_name'].toString(),
      avatarCustomer: json['avatar'].toString(),
      restaurantId: json['restaurant_id'].toString(),
      customerId: json['customer_id'].toString(),
      rate: double.parse(json['rate'].toString()),
      message: json['message'] as String,
      createAt: json['create_at'] as String,
    );
  }
}
