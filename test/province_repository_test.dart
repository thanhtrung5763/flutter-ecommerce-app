import 'package:final_project/models/District.dart';
import 'package:final_project/models/Province.dart';
import 'package:final_project/models/Ward.dart';
import 'package:final_project/services/repo/province_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProvinceRepository provinceRepository;

  setUp(() => provinceRepository = ProvinceRepository());
  group('Province Repository', () { 
    group('called getProvinces()', () { 
      test('return List<Province> with status code is 200', () async {
        final provinces = await provinceRepository.getProvinces();
        expect(provinces, everyElement(isA<Province>()));
      });
    });
    group('called getDistricts() with given provinceID', () { 
      test('provinceID is valid, return List<District> with status code is 200', () async {
        final provinceID = 64;
        final districts = await provinceRepository.getDistricts(provinceID);
        expect(districts, everyElement(isA<District>()));
      });
      test('provinceID is invalid, the response is a empty list, so cannot parse to List<District>, throws RangeError', () async {
        final provinceID = 0;
        expect(() => provinceRepository.getDistricts(provinceID), throwsRangeError);
      });
    });
    group('called getWards() with given districtID', () { 
      test('districtID is valid, return List<Ward> with status code is 200', () async {
        final districtID = 240;
        final wards = await provinceRepository.getWards(districtID);
        expect(wards, everyElement(isA<Ward>()));
      });
      test('districtID is invalid, the response is a empty list, so cannot parse to List<Ward>, throws RangeError', () async {
        final districtID = 0;
        expect(() => provinceRepository.getWards(districtID), throwsRangeError);
      });
    });
  });
}
