import 'dart:convert';

List<CountryCode> countryCodeFromJson(String str) => List<CountryCode>.from(
    json.decode(str).map((x) => CountryCode.fromJson(x)));

String countryCodeToJson(List<CountryCode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryCode {
  CountryCode({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
  });

  String name;
  String flag;
  String code;
  String dialCode;

  factory CountryCode.fromJson(Map<String, dynamic> json) => CountryCode(
        name: json["name"],
        flag: json["flag"],
        code: json["code"],
        dialCode: json["dial_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "flag": flag,
        "code": code,
        "dial_code": dialCode,
      };
}
