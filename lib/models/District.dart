import 'dart:convert';

List<District> districtsFromJson(String str) => List<District>.from(json.decode(str)['results'].map((x) => District.fromJson(x)));

District districtFromJson(String str) => District.fromJson(json.decode(str));

String districtToJson(List<District> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class District {
  final String districtId;
  final String districtName;
  final String districtType;
  final dynamic lat;
  final dynamic lng;
  final String provinceId;

  District({
    required this.districtId,
    required this.districtName,
    required this.districtType,
    this.lat,
    this.lng,
    required this.provinceId,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"],
        districtName: json["district_name"],
        districtType: json["district_type"],
        lat: json["lat"],
        lng: json["lng"],
        provinceId: json["province_id"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
        "district_type": districtType,
        "lat": lat,
        "lng": lng,
        "province_id": provinceId,
      };
}
