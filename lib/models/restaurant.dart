class Restaurant {
  String id;
  String name;
  String image;
  String description;
  String phoneNumber;
  double rate;
  DateTime joinDay;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.phoneNumber,
    required this.rate,
    required this.joinDay,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'].toString(),
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      phoneNumber: json['phone_number'] as String,
      rate: double.parse(json['rate'].toString()),
      joinDay: DateTime.parse(json['join_day'] as String),
    );
  }
}
