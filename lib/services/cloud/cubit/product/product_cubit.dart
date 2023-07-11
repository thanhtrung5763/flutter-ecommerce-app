import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/utils/queries.dart';
import 'package:final_project/services/cloud/product_service.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {

  final _productService = ProductService();
  List<String> item_ids = [];
  List<Product> products = [];
  int length = 0;
  GraphQLRequest<PaginatedResult<Product>>? requestForNextResult;
  String? nextToken;
  ProductCubit() : super(ProductInitial());

  void getSaleProducts() async {
    if (state is ProductLoaded == false) {
      emit(ProductLoading());
      const operation = 'listProducts';
      requestForNextResult =
        GraphQLRequest<PaginatedResult<Product>>(
          document: AppQuery.getSaleProducts(null),
          modelType: const PaginatedModelType(Product.classType),
          decodePath: operation
      );
    }
    try {
      if (requestForNextResult == null) {
        return;
      }
      final result =
          await _productService.getSaleProducts(requestForNextResult!);
      requestForNextResult = result['0'];
      final currentProductList = result['1'];
      products.addAll(List<Product>.from(currentProductList));
      emit(ProductLoaded(products, products.length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }

  void getNewProducts() async {
    // emit(ProductLoading());
    // try {
    //   final products = await _productService.getNewProducts();
    //   emit(ProductLoaded(products, products.length));
    // } on Exception catch (e) {
    //   emit(ProductError(e));
    // }
    if (state is ProductLoaded == false) {
      emit(ProductLoading());
      const operation = 'listProducts';
      requestForNextResult =
        GraphQLRequest<PaginatedResult<Product>>(
          document: AppQuery.getNewProducts(null),
          modelType: const PaginatedModelType(Product.classType),
          decodePath: operation
      );
    }
    try {
      if (requestForNextResult == null) {
        return;
      }
      final result =
          await _productService.getNewProducts(requestForNextResult!);
      requestForNextResult = result['0'];
      final currentProductList = result['1'];
      products.addAll(List<Product>.from(currentProductList));
      emit(ProductLoaded(products, products.length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }

  void getModelBasedRecommendForUser() async {
    emit(ProductLoading());
    try {
      final products = await _productService.getModelBasedRecommendForUser();
      emit(ProductLoaded(products, products.length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }

  void getContentBasedRecommendForUser(List<String> product_ids) async {
    emit(ProductLoading());
    try {
      final products = await _productService.getContentBasedRecommendForUser(product_ids);
      emit(ProductLoaded(products, products.length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }

  void getRecentlyViewProducts(List<String> product_ids) async {
    print("abc | $product_ids ");
    emit(ProductLoading());
    try {
      final products = await _productService.getRecentlyViewProducts(product_ids);
      emit(ProductLoaded(products, products.length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }
  // void createUpdateSavedStorage(Product product) async {
  //   emit(ProductSaving());
  //   try {
  //     await _productService.createUpdateSavedStorage(product);
  //     emit(ProductSaved());
  //   } on Exception catch (e) {
  //     emit(ProductError(e));
  //   }
  // }

  // void getSavedStorageOfUser() async {
  //   if (state is ProductLoaded == false) {
  //     emit(ProductLoading());
  //   }
  //   try {
  //     final products = await _productService.getSavedStorageOfUser();
  //     emit(ProductLoaded(products, products.length));
  //   } on Exception catch (e) {
  //     emit(ProductError(e));
  //   }
  // }

  // void deleteProductSavedStorage(Product product) async {
  //   await _productService.deleteProductSavedStorage(product);
  //   getSavedStorageOfUser();
  // }

// USELESS
  // void subscribe() {
  //   final subscriptionRequest =
  //       ModelSubscriptions.onDelete(SavedStorageProducts.classType);
  //   final Stream<GraphQLResponse<SavedStorageProducts>> operation =
  //       Amplify.API.subscribe(
  //     subscriptionRequest,
  //     onEstablished: () => print('Subscription established'),
  //   );
  //   subscription = operation.listen(
  //     (event) {
  //       print('Subscription event data received: ${event.data}');
  //       getSavedStorageOfUser();
  //     },
  //     onError: (Object e) => print('Error in subscription stream: $e'),
  //   );
  // }

  void getSimilarItemsOfProduct(String productID) async {
    if (state is ProductLoaded == false) {
      emit(ProductLoading());
      item_ids = await _productService.getSimilarItemsIDS(productID);
      length = item_ids.length;
    }
    try {
      if (item_ids == []) {
        return;
      }
      final result =
          await _productService.getSimilarItemsOfProduct(item_ids, productID);
      item_ids = result['0'];
      final currentProductList = result['1'];
      products.addAll(List<Product>.from(currentProductList));
      emit(ProductLoaded(products, length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }

  void getProductsOfFiner(FinerCategory finerCategory) async {
    if (state is ProductLoaded == false) {
      emit(ProductLoading());
      QueryPredicate predicate = (Product.FINERCATEGORY.eq(finerCategory.id));
      requestForNextResult =
          ModelQueries.list(Product.classType, where: predicate);
    }
    try {
      if (requestForNextResult == null) {
        return;
      }
      final result =
          await _productService.getProductsOfFiner(requestForNextResult);
      requestForNextResult = result['0'];
      final currentProductList = result['1'];
      products.addAll(List<Product>.from(currentProductList));
      emit(ProductLoaded(products, products.length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }

  void getProductsOfBrand(Brand brand) async {
    if (state is ProductLoaded == false) {
      emit(ProductLoading());
      QueryPredicate predicate = (Product.BRAND.eq(brand.id));
      requestForNextResult =
          ModelQueries.list(Product.classType, where: predicate);
    }
    try {
      if (requestForNextResult == null) {
        return;
      }
      final result =
          await _productService.getProductsOfBrand(requestForNextResult);
      requestForNextResult = result['0'];
      final currentProductList = result['1'];
      products.addAll(List<Product>.from(currentProductList));
      emit(ProductLoaded(products, products.length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }

  void getProductsOfSearch(String text) async {
    if (state is ProductLoaded == false) {
      emit(ProductLoading());
      text = text.toLowerCase();
      QueryPredicateGroup predicate = (Product.TITLE.contains(text)).or(Product.TITLE.contains(toBeginningOfSentenceCase(text)!));
      requestForNextResult =
          ModelQueries.list(Product.classType, where: predicate);
    }
    try {
      if (requestForNextResult == null) {
        return;
      }
      final result =
          await _productService.getProductsOfSearch(requestForNextResult);
      requestForNextResult = result['0'];
      final currentProductList = result['1'];
      products.addAll(List<Product>.from(currentProductList));
      emit(ProductLoaded(products, products.length));
    } on Exception catch (e) {
      emit(ProductError(e));
    }
  }
}
