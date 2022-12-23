// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthCredentials {
  final String username;
  String? email;
  final String password;
  String? userId;
  AuthCredentials({
    required this.username,
    this.email,
    required this.password,
    this.userId,
  });
}
