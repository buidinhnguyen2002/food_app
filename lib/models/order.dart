class Order {
  final String id;
  final String restaurantId;
  final String customerId;
  final String customerAddressId;
  final String deliveryDriverId;
  final DateTime orderDatetime;
  final double deliveryFee;
  final String unit;
  final double totalAmount;
  final DateTime requestedDeliveryDatetime;
  final bool isPaid;
  final int driverRatingOfCustomer;
  final int restaurantRatingOfCustomer;
  final String status;
  final String name;
  final String image;
  final int quantityItem;

  Order({
    required this.id,
    required this.restaurantId,
    required this.customerId,
    required this.customerAddressId,
    required this.deliveryDriverId,
    required this.orderDatetime,
    required this.deliveryFee,
    required this.unit,
    required this.totalAmount,
    required this.requestedDeliveryDatetime,
    required this.isPaid,
    required this.driverRatingOfCustomer,
    required this.restaurantRatingOfCustomer,
    required this.status,
    required this.name,
    required this.image,
    required this.quantityItem,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(),
      restaurantId: json['restaurant_id'].toString(),
      customerId: json['customer_id'].toString(),
      customerAddressId: json['customer_address_id'].toString(),
      deliveryDriverId: json['deliveryDriver_id'].toString(),
      orderDatetime: DateTime.parse(json['order_datetime'] as String),
      deliveryFee: double.parse(json['delivery_fee'].toString()),
      unit: json['unit'] as String,
      totalAmount: double.parse(json['total_amount'].toString()),
      requestedDeliveryDatetime:
          DateTime.parse(json['requested_delivery_datetime'] as String),
      isPaid: (json['is_paid'] as int) == 1 ? true : false,
      driverRatingOfCustomer:
          int.parse(json['driver_rating_of_customer'].toString()),
      restaurantRatingOfCustomer:
          int.parse(json['restaurant_rating_of_customer'].toString()),
      status: json['status'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      quantityItem: int.parse(json['quantity_item'].toString()),
    );
  }
}
