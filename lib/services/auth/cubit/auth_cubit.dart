import 'package:bloc/bloc.dart';
import 'package:final_project/services/auth/auth_credentials.dart';
import 'package:final_project/views/home/cubit/session_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthPageState> {
  final SessionCubit sessionCubit;
  AuthCubit({required this.sessionCubit}) : super(AuthPageState.logIn);

  AuthCredentials? credentials;
  void showLogin() => emit(AuthPageState.logIn);
  void showSignUp() => emit(AuthPageState.signUp);
  void showConfirmSignUp({
    required String username,
    required String email,
    required String password,
  }) {
    credentials = AuthCredentials(
      username: username,
      email: email,
      password: password,
    );
    emit(AuthPageState.confirmSignUp);
  }
  void launchSession(AuthCredentials credentials) => sessionCubit.showSession(credentials);
  void terminateSession() => sessionCubit.signOut();
}
