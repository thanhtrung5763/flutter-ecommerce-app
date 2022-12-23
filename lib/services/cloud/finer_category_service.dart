import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/models/BroadCategory.dart';
import 'package:final_project/models/FinerCategory.dart';

class FinerCategoryService {
  Future<List<FinerCategory>> getFinerCategoriesOfBroad(
      BroadCategory broadCategory) async {
    try {
      final request = ModelQueries.list(FinerCategory.classType,
          where: FinerCategory.BROADCATEGORYID.eq(broadCategory.id));
      final response = await Amplify.API.query(request: request).response;

      final finerCategories = response.data?.items;
      if (finerCategories == null) {
        print('errors: ${response.errors}');
        return [];
      }
      return finerCategories.whereType<FinerCategory>().toList();
    } on ApiException catch (e) {
      rethrow;
    }
  }
}
