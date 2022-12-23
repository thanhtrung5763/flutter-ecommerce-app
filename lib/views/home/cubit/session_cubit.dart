import 'package:bloc/bloc.dart';
import 'package:final_project/models/User.dart';
import 'package:final_project/services/auth/auth_credentials.dart';
import 'package:final_project/services/auth/auth_repository.dart';
import 'package:final_project/services/repo/user_repository.dart';
import 'package:meta/meta.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  SessionCubit({
    required this.authRepository,
    required this.userRepository,
  }) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }
  void attemptAutoLogin() async {
    try {
      final userId = await authRepository.attemptAutoLogin();
      if (userId == null) {
        throw Exception('User not logged in');
      }
      final u = await userRepository.getUserByID(userId);
      emit(Authenticated(user: u));
    } catch (e) {
      emit(Unauthenticated());
    }
    // try {
    //   final isUserSignedIn = await authRepository.isUserSignedIn();
    //   if (isUserSignedIn) {
    //     emit(Authenticated(user: null));
    //   }
    // } catch (e) {
    //   emit(Unauthenticated());
    // }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) async {
    // try {
    //   User? user = await userRepository.getUserById(credentials.userId!);
    //   if (user == null) {
    //     user = await userRepository.createUser(
    //       userId: credentials.userId!,
    //       username: credentials.username!,
    //       email: credentials.email!,
    //     );
    //   }
    //   emit(Authenticated(user: user));
    // } catch (e) {
    //   emit(Unauthenticated());
    // }
     try {
      final user = await authRepository.currentUser;
      // User? user = await userRepository.getUserById(credentials.userId!);
      // if (user == null) {
        // await userRepository.createUser(
        //   userId: credentials.userId!,
        //   username: credentials.username!,
        //   email: credentials.email!,
        // );
      // }
      final u = await userRepository.getUserByID(user!.userId);
      emit(Authenticated(user: u!));
    } catch (e) {
      emit(Unauthenticated());
    }
  }
  Future<void> signOut() async {
    emit(Unauthenticated());
  }
}
