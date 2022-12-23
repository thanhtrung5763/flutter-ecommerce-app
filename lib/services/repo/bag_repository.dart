import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/models/ModelProvider.dart';

class BagRepository {
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

  Future<Bag?> getBag() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final u = await getUserByID(user.userId);
      if (u == null) {
        print('no user');
        return null;
      }

      const getBag = 'listBags';
      String graphQLDocument = '''
      query GetBag(\$userID: ID!, \$bagStatus: BagStatus) {
        $getBag(filter: {userID: {eq: \$userID}, bagStatus: {eq: \$bagStatus}}) {
          items {
            id
            bagStatus
            BagProducts {
              items {
                id
                size
                quantity
                isRated
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
                          bagID
          productID
              }
            }
          }
        }
      }
''';

      final request = GraphQLRequest<String>(
        document: graphQLDocument,
        variables: <String, String>{'userID': u.id, 'bagStatus': 'HOLDING'},
      );
      final response = await Amplify.API.query(request: request).response;
      // final request = ModelQueries.list(Bag.classType, where: Bag.USER.eq(u.id).and(Bag.BAGSTATUS.eq(BagStatus.HOLDING)));
      // final response = await Amplify.API.query(request: request).response;
      final data = response.data;
      Map<String, dynamic> jsonData = json.decode(data!);
      if ((jsonData[getBag]['items'] as List).length == 0) {
        Bag bag = await createBag(u);
        return bag;
      } else {
        List<dynamic> productsData =
            jsonData[getBag]['items'][0]['BagProducts']['items'];

        List<BagProduct> bagProducts =
            List<BagProduct>.from(productsData.map((e) {
          Product product = Product.fromJson(e['product']);
          product =
              product.copyWith(brand: Brand.fromJson(e['product']['brand']));
          product = product.copyWith(
              finercategory:
                  FinerCategory.fromJson(e['product']['finercategory']));

          BagProduct bagProduct = BagProduct.fromJson(e);
          bagProduct = bagProduct.copyWith(product: product);
          return bagProduct;
        }));
        Bag bag = Bag.fromJson(jsonData[getBag]['items'][0]);
        bag = bag.copyWith(BagProducts: bagProducts);
        return bag;
      }
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<Bag> createBag(User user) async {
    try {
      Bag bag = Bag(bagStatus: BagStatus.HOLDING, user: user);
      final request = ModelMutations.create(bag);
      final response = await Amplify.API.mutate(request: request).response;
      return bag;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<BagProduct> createBagProduct(
      Bag bag, Product product, String size) async {
    try {
      BagProduct bagProduct = BagProduct(
          bagID: bag.id,
          productID: product.id,
          product: product,
          size: size,
          quantity: 1,
          isRated: false);
      final request = ModelMutations.create(bagProduct);
      final response = await Amplify.API.mutate(request: request).response;
      return bagProduct;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<void> updateBagProduct(BagProduct bagProduct) async {
    try {
      final request = ModelMutations.update(bagProduct);
      await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBagProduct(String id) async {
    try {
      final request = ModelMutations.deleteById(BagProduct.classType, id);
      await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<void> updateBagStatus(Bag bag) async {
    try {
      final request = ModelMutations.update(bag);
      await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<List<Bag>> getOrders() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final u = await getUserByID(user.userId);
      if (u == null) {
        print('no user');
        return [];
      }

      const getOrders = 'gsiBagByUser';
      String graphQLDocument = '''
      query GetOrdersOfUser(\$userID: ID!, \$bagStatus: BagStatus) {
        $getOrders(userID: \$userID, filter: {bagStatus: {ne: \$bagStatus}}) {
          items {
            id
            bagStatus
            BagProducts {
              items {
                id
                size
                quantity
                isRated
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
                bagID
                productID
              }
            }
          }
        }
      }
''';

      final request = GraphQLRequest<String>(
        document: graphQLDocument,
        variables: <String, String>{'userID': u.id, 'bagStatus': 'HOLDING'},
      );
      final response = await Amplify.API.query(request: request).response;
      // final request = ModelQueries.list(Bag.classType, where: Bag.USER.eq(u.id).and(Bag.BAGSTATUS.eq(BagStatus.HOLDING)));
      // final response = await Amplify.API.query(request: request).response;
      final data = response.data;
      Map<String, dynamic> jsonData = json.decode(data!);
      List<dynamic> ordersData = jsonData[getOrders]['items'];
      List<Bag> orders = [];
      if (ordersData.isEmpty) {
        return [];
      } else {
        for (int i = 0; i < ordersData.length; i++) {
          List<dynamic> productsData = ordersData[i]['BagProducts']['items'];

          List<BagProduct> bagProducts =
              List<BagProduct>.from(productsData.map((e) {
            Product product = Product.fromJson(e['product']);
            product =
                product.copyWith(brand: Brand.fromJson(e['product']['brand']));
            product = product.copyWith(
                finercategory:
                    FinerCategory.fromJson(e['product']['finercategory']));

            BagProduct bagProduct = BagProduct.fromJson(e);
            bagProduct = bagProduct.copyWith(product: product);
            return bagProduct;
          }));
          Bag bag = Bag.fromJson(ordersData[i]);
          bag = bag.copyWith(BagProducts: bagProducts);
          orders.add(bag);
        }
      }
      return orders;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<void> addReview(String bagID, String productID, String rating) async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      Review review = Review(
          bagID: bagID,
          userID: user.userId,
          productID: productID,
          rating: rating);
      final request = ModelMutations.create(review);
      await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      rethrow;
    }
  }
}
