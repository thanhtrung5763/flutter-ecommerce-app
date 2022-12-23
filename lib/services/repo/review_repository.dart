import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/models/Product.dart';
import 'package:final_project/models/Review.dart';

class ReviewRepository {
  Future<List<Review>> getReviewByProduct(Product product) async {
    try {
      const gsiReviewByProduct = 'gsiReviewByProduct';
      String graphQLDocument = '''
      query GSIReviewByProduct(\$productID: ID!) {
        $gsiReviewByProduct(productID: \$productID) {
          items {
            id
            bagID
            userID
            productID
            rating
          }
        }
      }
''';
      final request = GraphQLRequest<String>(
          document: graphQLDocument,
          variables: <String, String>{
            'productID': product.id,
          });
      final response = await Amplify.API.query(request: request).response;
      final data = response.data;
      Map<String, dynamic> jsonData = json.decode(data!);
      List<dynamic> items = jsonData[gsiReviewByProduct]['items'];
      final reviews = List<Review>.from(items.map((e) => Review.fromJson(e)));
      return reviews;
    } on ApiException catch (e) {
      rethrow;
    }
  }
}
