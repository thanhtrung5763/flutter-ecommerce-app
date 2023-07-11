part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}


class AuthEventLogIn extends AuthEvent {
  final String username;
  final String password;

  const AuthEventLogIn(this.username, this.password);
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventSignUp extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const AuthEventSignUp(this.username, this.email, this.password);
} 

class AuthEventConfirmSignUp extends AuthEvent {
  final String confirmationCode;

  const AuthEventConfirmSignUp(this.confirmationCode);
}

class AuthEventResendSignUpCode extends AuthEvent {
  const AuthEventResendSignUpCode();
}



