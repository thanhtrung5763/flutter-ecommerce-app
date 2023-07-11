import 'dart:convert';

List<Province> provincesFromJson(String str) => List<Province>.from(json.decode(str)['results'].map((x) => Province.fromJson(x)));

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
    final String provinceId;
    final String provinceName;
    final String provinceType;

    Province({
        required this.provinceId,
        required this.provinceName,
        required this.provinceType,
    });

    factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"],
        provinceName: json["province_name"],
        provinceType: json["province_type"],
    );

    Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province_name": provinceName,
        "province_type": provinceType,
    };
}