class Address {
  final String id;
  final String name;
  final String district;
  final String ward;
  final String addressDetail;
  final double latitude;
  final double longitude;

  Address(
      {required this.id,
      required this.name,
      required this.district,
      required this.ward,
      required this.addressDetail,
      required this.latitude,
      required this.longitude});
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'].toString() ?? '',
      name: json['name'].toString() ?? '',
      district: json['district'].toString() ?? '',
      ward: json['ward'].toString() ?? '',
      addressDetail: json['address_detail'].toString() ?? '',
      latitude: double.parse(json['latitude'].toString()) ?? 0.0,
      longitude: double.parse(json['longitude'].toString()) ?? 0.0,
    );
  }
  String get address {
    return "$addressDetail, $ward, ${district}Tp.HCM";
  }
}
