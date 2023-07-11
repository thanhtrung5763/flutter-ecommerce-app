import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/models/User.dart';

class UserRepository {
  Future<User?> getUserByID(String id) async {
    try {
      final request = ModelQueries.get(User.classType, id);
      final response = await Amplify.API.query(request: request).response;

      final user = response.data;
      return user;
    } on ApiException {
      rethrow;
    }
  }

  Future<User?> createUser({
    required String userId,
    required String username,
    required String email,
  }) async {
    final user = User(id: userId, username: username, email: email, savedStorageID: userId);
    try {
      // final response = await Amplify.DataStore.save(user);
      final request = ModelMutations.create(user);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response Create User: ${response.data}');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> updateUser(User newUser) async {
    final request = ModelMutations.update(newUser);
    final response = await Amplify.API.mutate(request: request).response;

    safePrint('Response Update User: ${response.data}');
    return response.data;
  }
}
