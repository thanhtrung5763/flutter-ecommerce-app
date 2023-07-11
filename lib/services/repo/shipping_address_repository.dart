import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/repo/user_repository.dart';

class ShippingAddressRepository {
  User currentUser;

  ShippingAddressRepository({required this.currentUser});

  Future<List<ShippingAddress>> getShippingAddresses() async {
    try {
      final userID = currentUser.id;

      final request = ModelQueries.list(ShippingAddress.classType, where: ShippingAddress.USERID.eq(userID));
      final response = await Amplify.API.query(request: request).response;
      final data = response.data?.items.whereType<ShippingAddress>().toList() ?? <ShippingAddress>[];
      return data;
    } on ApiException {
      rethrow;
    }
  }

  Future<Bag> createBag(User user) async {
    try {
      Bag bag = Bag(bagStatus: BagStatus.HOLDING, user: user);
      final request = ModelMutations.create(bag);
      final response = await Amplify.API.mutate(request: request).response;
      return bag;
    } on ApiException {
      rethrow;
    }
  }

  Future<ShippingAddress?> createShippingAddress(ShippingAddress shippingAddress, bool isDefault) async {
    try {
      shippingAddress = shippingAddress.copyWith(userID: currentUser.id);
      final request = ModelMutations.create(shippingAddress);
      final response = await Amplify.API.mutate(request: request).response;

      final createdShippingAddress = response.data;
      if (createdShippingAddress == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }
      if (isDefault == true) {
        currentUser = currentUser.copyWith(defaultShippingAddressID: createdShippingAddress.id);
        UserRepository().updateUser(currentUser);
      }
      safePrint('Mutation result: ${createdShippingAddress.name}');
      return createdShippingAddress;
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      rethrow;
    }
  }

  Future<ShippingAddress?> updateShippingAddress(ShippingAddress shippingAddress, bool isDefault) async {
    final request = ModelMutations.update(shippingAddress);
    final response = await Amplify.API.mutate(request: request).response;
    final updatedShippingAddress = response.data;
    if (isDefault == true && updatedShippingAddress != null) {
      currentUser = currentUser.copyWith(defaultShippingAddressID: updatedShippingAddress.id);
      UserRepository().updateUser(currentUser);
    }
    safePrint('Response: $response');
    return updatedShippingAddress;
  }
}
