import 'dart:convert';

class District {
  String name;
  int code;
  String divisionType;
  String codename;
  int provinceCode;

  District({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.codename,
    required this.provinceCode,
  });
  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: utf8.decode(json['name'].toString().codeUnits) ?? '',
      code: int.parse(json['code'].toString()) ?? 0,
      divisionType: json['division_type'] ?? '',
      codename: json['codename'] ?? '',
      provinceCode: int.parse(json['province_code'].toString()) ?? 0,
    );
  }
}
