part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final FormSubmissionStatus formStatus;
  const AuthState({required this.formStatus});
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial({required super.formStatus});
}

class AuthStateLogIn extends AuthState {
  final String? username;
  final String? password;

  final FormSubmissionStatus formStatus;

  const AuthStateLogIn({
    this.username,
    this.password,
    required this.formStatus,
  }) : super(formStatus: formStatus);
}

class AuthStateSignUp extends AuthState {
  final String? username;
  final String? email;
  final String? password;

  final FormSubmissionStatus formStatus;

  const AuthStateSignUp({
    this.username,
    this.email,
    this.password,
    required this.formStatus,
  }) : super(formStatus: formStatus);
}

class AuthStateConfirmSignUp extends AuthState {
  final String? username;
  final String? confirmationCode;

  final FormSubmissionStatus formStatus;

  const AuthStateConfirmSignUp({
    required this.username,
    this.confirmationCode,
    required this.formStatus,
  }) : super(formStatus: formStatus);
}

class AuthStateSignOut extends AuthState {
  const AuthStateSignOut({required super.formStatus});
}
