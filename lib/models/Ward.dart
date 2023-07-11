import 'dart:convert';

List<Ward> wardsFromJson(String str) => List<Ward>.from(json.decode(str)['results'].map((x) => Ward.fromJson(x)));

Ward wardFromJson(String str) => Ward.fromJson(json.decode(str));

String wardToJson(List<Ward> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ward {
    final String districtId;
    final String wardId;
    final String wardName;
    final String wardType;

    Ward({
        required this.districtId,
        required this.wardId,
        required this.wardName,
        required this.wardType,
    });

    factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        districtId: json["district_id"],
        wardId: json["ward_id"],
        wardName: json["ward_name"],
        wardType: json["ward_type"],
    );

    Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "ward_id": wardId,
        "ward_name": wardName,
        "ward_type": wardType,
    };
}