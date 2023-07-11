import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/models/Brand.dart';

class BrandService {
  Future<Brand?> getBrandByID(String brandId) async {
    try {
      final request = ModelQueries.get(Brand.classType,
          brandId);
      final response = await Amplify.API.query(request: request).response;

      final brand = response.data;
      return brand;
    } on ApiException catch (e) {
      rethrow;
    }
  }
}
