import 'package:final_project/models/User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
class UserRepository {
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

  Future<User> createUser({
    required String userId,
    required String username,
    required String email,
  }) async {
    final user = User(id: userId,username: username, email: email,);
    try {
      final response = await Amplify.DataStore.save(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }
}