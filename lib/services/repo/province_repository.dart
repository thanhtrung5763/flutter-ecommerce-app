import 'package:final_project/models/District.dart';
import 'package:final_project/models/Province.dart';
import 'package:final_project/models/Ward.dart';
import 'package:http/http.dart' as http;

class ProvinceRepository {
  Future<List<Province>> getProvinces() async {
    try {
      var response = await http.get(
        Uri.parse('https://vapi.vnappmob.com/api/province'),
        headers: {'Content-Type': 'application/json'},
      );
      // ignore: avoid_print
      List<Province> provinces = provincesFromJson(response.body);
      print(provinces[0].provinceName);
      return provinces;
    } on Exception {
      rethrow;
    }
  }

  Future<List<District>> getDistricts(int provinceID) async {
    try {
      var response = await http.get(
        Uri.parse('https://vapi.vnappmob.com/api/province/district/$provinceID'),
        headers: {'Content-Type': 'application/json'},
      );
      // ignore: avoid_print
      List<District> districts = districtsFromJson(response.body);
      print(districts[0].districtName);
      return districts;
    } on Exception {
      rethrow;
    }
  }

  Future<List<Ward>> getWards(int districtID) async {
    try {
      var response = await http.get(
        Uri.parse('https://vapi.vnappmob.com/api/province/ward/$districtID'),
        headers: {'Content-Type': 'application/json'},
      );
      // ignore: avoid_print
      List<Ward> wards = wardsFromJson(response.body);
      print(wards[0].wardName);
      return wards;
    } on Exception {
      rethrow;
    }
  }
}
