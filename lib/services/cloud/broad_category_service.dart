import 'package:final_project/models/BroadCategory.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
class BroadCategoryService {
  Future<List<BroadCategory>> getBroadCategories(String gender) async {
    try {
      gender = gender.toUpperCase();
      final request = ModelQueries.list(BroadCategory.classType, where: BroadCategory.GENDER.eq(gender));
      final response = await Amplify.API.query(request: request).response;

      final broadCategories = response.data?.items;
      if (broadCategories == null) {
print('errors: ${response.errors}');
      return [];
      }
       return broadCategories.whereType<BroadCategory>().toList();
    } on ApiException catch (e) {
      rethrow;
    }
  }
}