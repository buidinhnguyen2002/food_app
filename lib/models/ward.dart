import 'dart:convert';

class Ward {
  String name;
  int code;
  String divisionType;
  String codename;
  int districtCode;

  Ward({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.codename,
    required this.districtCode,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      name: utf8.decode(json['name'].toString().codeUnits) ?? '',
      code: json['code'] ?? 0,
      divisionType:
          utf8.decode(json['division_type'].toString().codeUnits) ?? '',
      codename: utf8.decode(json['codename'].toString().codeUnits) ?? '',
      districtCode: json['district_code'] ?? 0,
    );
  }
}
