import 'dart:convert';

import 'package:final_project/models/ModelProvider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';

class SavedStorageRepository {
  Future<User?> getUserByID(String id) async {
    try {
      final request = ModelQueries.get(User.classType, id);
      final response = await Amplify.API.query(request: request).response;

      final user = response.data;
      return user;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<SavedStorage?> getSavedStorage() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final u = await getUserByID(user.userId);
      if (u == null) {
        print('no user');
        return null;
      }

      const getSavedStorage = 'getSavedStorage';
      String graphQLDocument = '''
      query GetSavedStorage(\$id: ID!) {
        $getSavedStorage(id: \$id) {
          id
          SavedStorageProducts {
            items {
              id
              productID
              savedStorageID
              product {
                id
                  title
                  images
                  description
                  discountPrice
                  originalPrice
                  discountOffer
                  sizeOption
                  finercategory {
                    id
                    title
                  }
                  brand {
                    id
                    title
                  }
              }
            }
          }
        }
      }
''';



      final request = GraphQLRequest<String> (document: graphQLDocument,
      variables: <String, String>{'id': u.getId()});
      final response = await Amplify.API.query(request: request).response;
      final data = response.data;
      print('dataabcxyz: $data');
      if (data != null) {
        Map<String, dynamic> jsonData = json.decode(data);
        if (jsonData[getSavedStorage] != null) {
          List<dynamic> productsData = jsonData[getSavedStorage]['SavedStorageProducts']['items'];
          List<SavedStorageProduct> savedStorageProducts = List<SavedStorageProduct>.from(productsData.map((e) {
            Product product = Product.fromJson(e['product']);
            product =
                product.copyWith(brand: Brand.fromJson(e['product']['brand']));
            product = product.copyWith(
                finercategory:
                    FinerCategory.fromJson(e['product']['finercategory']));

            SavedStorageProduct savedStorageProduct = SavedStorageProduct.fromJson(e);
            savedStorageProduct = savedStorageProduct.copyWith(product: product);
            return savedStorageProduct;
          }));
          SavedStorage savedStorage = SavedStorage.fromJson(jsonData[getSavedStorage]);
          savedStorage = savedStorage.copyWith(SavedStorageProducts: savedStorageProducts);
          return savedStorage;
        }
      }
      SavedStorage savedStorage = await createSavedStorage(u.getId());
      return savedStorage;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<SavedStorage> createSavedStorage(String userID) async {
    try {
      SavedStorage savedStorage = SavedStorage(id: userID);
      savedStorage = savedStorage.copyWith(SavedStorageProducts: List.empty(growable: true));
      final request = ModelMutations.create(savedStorage);
      final response = await Amplify.API.query(request: request).response;
      print("savestorageabcxyz: ${response.data}");
      return savedStorage;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<SavedStorageProduct> createSavedStorageProduct(SavedStorage savedStorage, Product product) async {
    try {
      SavedStorageProduct savedStorageProduct = SavedStorageProduct(
        savedStorageID: savedStorage.id,
        productID: product.id,
        product: product
      );
      final request = ModelMutations.create(savedStorageProduct);
      final response = await Amplify.API.mutate(request: request).response;
      return savedStorageProduct;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSavedStorageProduct(String id) async {
    try {
      final request = ModelMutations.deleteById(SavedStorageProduct.classType, id);
      await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      rethrow;
    }
  }

}