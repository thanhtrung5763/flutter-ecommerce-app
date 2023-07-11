import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository {
  Future<AuthUser?> get currentUser async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      return user;
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<bool> isUserSignedIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true));
      final credentials = (session as CognitoAuthSession).credentials;

      return session.isSignedIn;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _getUserId() async {
    try {
      // final attributes = await Amplify.Auth.getCurrentUser();
      // final userId = attributes
      //     .firstWhere((element) => element.userAttributeKey == 'sub')
      //     .value;
      // if (userId != null) {
      //   return userId;
      // }
      // return '123';
      final user = await currentUser;
      if (user != null) {
        return user.userId;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> attemptAutoLogin() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession(
          );
      return session.isSignedIn ? (await _getUserId()) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username.trim(),
        password: password.trim(),
      );
      return result.isSignedIn ? (await _getUserId()) : null;
    } on AuthException catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.custom('role'): 'USER',
        CognitoUserAttributeKey.custom('username'): username.trim(),
        CognitoUserAttributeKey.email: email.trim(),
      };
      final result = await Amplify.Auth.signUp(
        username: username.trim(),
        password: password.trim(),
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      return result.isSignUpComplete;
    } on AuthException catch (e) {
      rethrow;
    }
  }

  Future<bool> confirmSignUp({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username.trim(),
        confirmationCode: confirmationCode.trim(),
      );
      return result.isSignUpComplete;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resendSignUpCode({
    required String username,
  }) async {
    try {
      final result = await Amplify.Auth.resendSignUpCode(
        username: username.trim(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}
