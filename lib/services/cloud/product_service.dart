import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/utils/queries.dart';

class ProductService {
  Future<Map<String, dynamic>> getSaleProducts(GraphQLRequest<PaginatedResult<Product>> request) async {
    // final request = ModelQueries.list(Product.classType,
    //     limit: 30, where: (Product.DISCOUNTOFFER.ne('')));
    // final response = await Amplify.API.query(request: request).response;

    // final products = response.data?.items;
    // if (products == null) {
    //   print('errors: ${response.errors}');
    //   return [];
    // }
    // return products.whereType<Product>().toList();

    const operation = 'listProducts';
    var products = [];
    // final request = GraphQLRequest<PaginatedResult<Product>>(
    //         document: AppQuery.getSaleProducts,
    //         modelType: const PaginatedModelType(Product.classType),
    //         decodePath: operation
    // );
    GraphQLResponse<PaginatedResult<Product>> response = await Amplify.API.query(request: request).response;
    GraphQLRequest<PaginatedResult<Product>>? requestForNextResult;
    for (int i = 0; i < 2; i++) {
      if (response.data!.hasNextResult == true) {
        products.addAll(response.data!.items);
        requestForNextResult = GraphQLRequest<PaginatedResult<Product>>(
            document: AppQuery.getSaleProducts(response.data!.nextToken!),
            modelType: const PaginatedModelType(Product.classType),
            decodePath: operation
        );
        response = await Amplify.API.query(request: requestForNextResult).response;
      }
    }
    Map<String, dynamic> result = Map();
    result['0'] = requestForNextResult;
    result['1'] = products;
    return result;
    // final data = response.data;
    // Map<String, dynamic> jsonData = json.decode(data!);
    // dynamic productsData =jsonData[operation]['items'];
    // List<Product> products = List<Product>.from(productsData.map((e) {
    //       Product product = Product.fromJson(e);
    //       product =
    //           product.copyWith(brand: Brand.fromJson(e['brand']));
    //       product = product.copyWith(
    //           finercategory:
    //               FinerCategory.fromJson(e['finercategory']));
    //       List<Review> reviews = List<Review>.from(e['Reviews']['items'].map((r) => Review.fromJson(r)));
    //       product = product.copyWith(
    //           Reviews: reviews);
    //       return product;
    //     }));
    // return products;

    // List<Product> products = [];
    // if (data != null) {
    //   products = data.items.whereType<Product>().toList();
    // }
    // return products;
  }

  Future<Map<String, dynamic>> getNewProducts(GraphQLRequest<PaginatedResult<Product>> request) async {
    // final request = ModelQueries.list(
    //   Product.classType,
    //   limit: 10,
    //   where: (Product.DISCOUNTOFFER.eq('')),
    // );
    // final response = await Amplify.API.query(request: request).response;

    // final products = response.data?.items;
    // if (products == null) {
    //   print('errors: ${response.errors}');
    //   return [];
    // }
    // return products.whereType<Product>().toList();

    const operation = 'listProducts';
    var products = [];

    GraphQLResponse<PaginatedResult<Product>> response = await Amplify.API.query(request: request).response;
    GraphQLRequest<PaginatedResult<Product>>? requestForNextResult;
    for (int i = 0; i < 2; i++) {
      if (response.data!.hasNextResult == true) {
        products.addAll(response.data!.items);
        requestForNextResult = GraphQLRequest<PaginatedResult<Product>>(
            document: AppQuery.getNewProducts(response.data!.nextToken!),
            modelType: const PaginatedModelType(Product.classType),
            decodePath: operation
        );
        response = await Amplify.API.query(request: requestForNextResult).response;
      }
    }
    Map<String, dynamic> result = Map();
    result['0'] = requestForNextResult;
    result['1'] = products;
    return result;
  }

/* THIS IS FOR GET RECOMMEND PRODUCT FROM API GATEWAY
  Future<List<Product>> getRecommendProducts() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(
        'https://eahzknovz4.execute-api.ap-southeast-1.amazonaws.com/dev?user_id=ee9ce40d-70b9-442a-96cb-79eba28279ab'));
    final val = response.body;
    List<dynamic> item_ids = json.decode(val)['data'];
    final products = [];
    for (int i = 0; i < item_ids.length; i++) {
      Product? product = await getProductByID(item_ids[i]);
      products.add(product);
    }
    if (products == null) {
      print('errors: ${response.toString()}');
      return [];
    }
    return products.whereType<Product>().toList();
  }
  */
  Future<Product?> getProductByID(String id) async {
    // final request = ModelQueries.get(Product.classType, id);
    // final response = await Amplify.API.query(request: request).response;

    // final product = response.data;

    // return product;

    const operation = 'getProduct';
    final request = GraphQLRequest<String>(
            document: AppQuery.getProductByID(id),
    );
    final response = await Amplify.API.query(request: request).response;
    final data = response.data;
    Map<String, dynamic> jsonData = json.decode(data!);
    dynamic productData =jsonData[operation];
    Product product = Product.fromJson(productData);
    product =
        product.copyWith(brand: Brand.fromJson(productData['brand']));
    product = product.copyWith(
        finercategory:
            FinerCategory.fromJson(productData['finercategory']));
    List<Review> reviews = List<Review>.from(productData['Reviews']['items'].map((r) => Review.fromJson(r)));
    product = product.copyWith(
        Reviews: reviews);
    return product;
  }

  Future<List<Product>> getModelBasedRecommendForUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    final userID = user.userId;
    final request = ModelQueries.get(ModelBased.classType, userID);
    final response = await Amplify.API.query(request: request).response;

    final item_ids = (response.data?.products)!.split(',');

    final products = [];
    for (int i = 0; i < item_ids.length; i++) {
      Product? product = await getProductByID(item_ids[i]);
      products.add(product);
    }
    return products.whereType<Product>().toList();
  }

  Future<List<Product>> getContentBasedRecommendForUser(
      List<String> product_ids) async {
    List<String> items = [
      // '422c5a18-da6e-4e4c-9c91-b53e0d09e766',
      // 'ee06e639-9457-46f5-9675-fde284b8cde2',
      // '74258902-8aaf-4a85-ae42-96e4ecf246de',
      ...product_ids
    ];
    if (items.isEmpty) {
      return [];
    }
    List<String> item_ids = [];
    int range = (items.length <= 6 ? 6 / items.length : 1).toInt();
    for (int i = 0; i < items.length; i++) {
      final request = ModelQueries.get(ContentBased.classType, items[i]);
      final response = await Amplify.API.query(request: request).response;
      item_ids.addAll((response.data?.products)!.split(',').getRange(0, range));
    }

    final products = [];
    for (int i = 0; i < item_ids.length; i++) {
      Product? product = await getProductByID(item_ids[i]);
      products.add(product);
    }
    return products.whereType<Product>().toList();
  }

  Future<List<Product>> getRecentlyViewProducts(
      List<String> product_ids) async {
    
    final products = [];
    for (int i = 0; i < product_ids.length; i++) {
      Product? product = await getProductByID(product_ids[i]);
      products.add(product);
    }
    return products.whereType<Product>().toList();
  }

  Future<SavedStorage?> getSavedStorageByID(String id) async {
    try {
      const getSavedStorage = 'getSavedStorage';
      String graphQLDocument = '''query GetSavedStorage(\$id: ID!) {
        $getSavedStorage(id: \$id) {
          id
          Products {
            items {
              id
            }
          }
        }
        }''';
      final getSavedStorageRequest = GraphQLRequest<SavedStorage>(
          document: graphQLDocument,
          modelType: SavedStorage.classType,
          variables: <String, String>{'id': id},
          decodePath: getSavedStorage);
      // final request = ModelQueries.get(SavedStorage.classType, id);
      final response =
          await Amplify.API.query(request: getSavedStorageRequest).response;

      final savedStorage = response.data;
      return savedStorage;
    } on ApiException catch (e) {
      rethrow;
    }
  }

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

  Future<Map<String, dynamic>> getSimilarItemsOfProduct(
      List<String> item_ids, String productID) async {
    try {
      List<String> query_item_ids;
      List<String> next_item_ids;
      if (item_ids.length >= 6) {
        query_item_ids = item_ids.getRange(0, 6).toList();
        next_item_ids = item_ids.getRange(6, item_ids.length).toList();
      } else {
        query_item_ids = item_ids;
        next_item_ids = [];
      }
      final products = [];
      for (int i = 0; i < query_item_ids.length; i++) {
        Product? product = await getProductByID(query_item_ids[i]);
        products.add(product);
      }

      // QueryPredicateGroup a =
      //     Product.ID.eq(item_ids[0]).or(Product.ID.eq(item_ids[1]));
      // print(item_ids.length);
      // for (int i = 2; i < item_ids.length; i++) {
      //   QueryPredicate predicate = (Product.ID.eq(item_ids[i]));
      //   a = a.or(predicate);
      // }
      // final request2 = ModelQueries.list(Product.classType, where: a);
      // GraphQLResponse<PaginatedResult<Product>> response2 =
      //     await Amplify.API.query(request: request2).response;
      // while (response2.data!.hasNextResult == true) {
      //   products.addAll(response2.data!.items);
      //   response2 = await Amplify.API
      //       .query(request: response2.data!.requestForNextResult!)
      //       .response;
      // }
      // if (products == null) {
      //   print('errors: ${response2.errors}');
      //   return [];
      // }

      Map<String, dynamic> result = Map();
      result['0'] = next_item_ids;
      result['1'] = products;
      return result;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getSimilarItemsIDS(String productID) async {
    try {
      List<String> item_ids = [];

      final request = ModelQueries.get(ContentBased.classType, productID);
      final response = await Amplify.API.query(request: request).response;
      item_ids.addAll((response.data?.products)!.split(','));
      return item_ids;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getProductsOfFiner(
      GraphQLRequest<PaginatedResult<Product>>? request) async {
    try {
      final products = [];
      GraphQLResponse<PaginatedResult<Product>> response =
          await Amplify.API.query(request: request!).response;
      GraphQLRequest<PaginatedResult<Product>>? requestForNextResult;
      for (int i = 0; i < 2; i++) {
        if (response.data!.hasNextResult == true) {
          final data = response.data;
          products.addAll(response.data!.items);
          requestForNextResult = response.data!.requestForNextResult!;
          response = await Amplify.API
              .query(request: response.data!.requestForNextResult!)
              .response;
        }
      }

      Map<String, dynamic> result = Map();
      result['0'] = requestForNextResult;
      result['1'] = products;
      return result;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getProductsOfBrand(
      GraphQLRequest<PaginatedResult<Product>>? request) async {
    try {
      final products = [];
      GraphQLResponse<PaginatedResult<Product>> response =
          await Amplify.API.query(request: request!).response;
      GraphQLRequest<PaginatedResult<Product>>? requestForNextResult;
      for (int i = 0; i < 2; i++) {
        if (response.data!.hasNextResult == true) {
          final data = response.data;
          products.addAll(response.data!.items);
          requestForNextResult = response.data!.requestForNextResult!;
          response = await Amplify.API
              .query(request: response.data!.requestForNextResult!)
              .response;
        }
      }

      Map<String, dynamic> result = Map();
      result['0'] = requestForNextResult;
      result['1'] = products;
      return result;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<FinerCategory?> getFinerCategoryByID(String id) async {
    try {
      final request = ModelQueries.get(FinerCategory.classType, id);
      final response = await Amplify.API.query(request: request).response;

      final finerCategory = response.data;
      return finerCategory;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getProductsOfSearch(String text,
      GraphQLRequest<PaginatedResult<Product>> request) async {
    try {
      // final products = [];
      // GraphQLResponse<PaginatedResult<Product>> response =
      //     await Amplify.API.query(request: request!).response;
      // GraphQLRequest<PaginatedResult<Product>>? requestForNextResult;
      // for (int i = 0; i < 2; i++) {
      //   if (response.data!.hasNextResult == true) {
      //     final data = response.data;
      //     products.addAll(response.data!.items);
      //     requestForNextResult = response.data!.requestForNextResult!;
      //     response = await Amplify.API
      //         .query(request: response.data!.requestForNextResult!)
      //         .response;
      //   }
      // }

      // Map<String, dynamic> result = Map();
      // result['0'] = requestForNextResult;
      // result['1'] = products;
      // return result;
      const operation = 'listProducts';
      var products = [];

      GraphQLResponse<PaginatedResult<Product>> response = await Amplify.API.query(request: request).response;
      GraphQLRequest<PaginatedResult<Product>>? requestForNextResult;
      for (int i = 0; i < 2; i++) {
        if (response.data!.hasNextResult == true) {
          products.addAll(response.data!.items);
          requestForNextResult = GraphQLRequest<PaginatedResult<Product>>(
              document: AppQuery.getProductsOfSearch(text, response.data!.nextToken!),
              modelType: const PaginatedModelType(Product.classType),
              decodePath: operation
          );
          response = await Amplify.API.query(request: requestForNextResult).response;
        }
      }
      Map<String, dynamic> result = Map();
      result['0'] = requestForNextResult;
      result['1'] = products;
      return result;
    } on ApiException catch (e) {
      rethrow;
    }
  }

}
