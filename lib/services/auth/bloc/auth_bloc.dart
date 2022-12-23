import 'package:bloc/bloc.dart';
import 'package:final_project/services/auth/auth_credentials.dart';
import 'package:final_project/services/auth/auth_repository.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/services/auth/cubit/form_submission_status.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;
  AuthBloc({required this.authRepo, required this.authCubit})
      : super(const AuthStateInitial(formStatus: InitialFormStatus())) {
    on<AuthEventSignUp>((event, emit) async {
      emit(AuthStateSignUp(
        formStatus: FormSubmitting(),
      ));
      final username = event.username;
      final email = event.email;
      final password = event.password;
      try {
        await authRepo.signUp(
          username: username,
          email: email,
          password: password,
        );
        emit(AuthStateSignUp(
          username: username,
          email: email,
          password: password,
          formStatus: SubmissionSuccess(),
        ));
        authCubit.showConfirmSignUp(
          username: username,
          email: email,
          password: password,
        );
      } on Exception catch (e) {
        emit(AuthStateSignUp(
          formStatus: SubmissionFailed(e),
        ));
      }
    });
    on<AuthEventConfirmSignUp>((event, emit) async {
      emit(
          AuthStateConfirmSignUp(username: null, formStatus: FormSubmitting()));
      final confirmationCode = event.confirmationCode;
      final credentials = authCubit.credentials;
      if (credentials != null) {
        try {
          await authRepo.confirmSignUp(
            username: credentials.username,
            confirmationCode: confirmationCode,
          );
          emit(
            AuthStateConfirmSignUp(
              username: credentials.username,
              formStatus: SubmissionSuccess(),
            ),
          );
          // await authRepo.signOut();
          final userId = await authRepo.logIn(
              username: credentials.username, password: credentials.password);
          credentials.userId = userId;
          authCubit.launchSession(credentials);
        } on Exception catch (e) {
          emit(
            AuthStateConfirmSignUp(
              username: credentials.username,
              formStatus: SubmissionFailed(e),
            ),
          );
        }
      }
    });
    on<AuthEventLogIn>((event, emit) async {
      emit(AuthStateLogIn(formStatus: FormSubmitting()));
      try {
        // await authRepo.signOut();

        final username = event.username;
        final password = event.password;
        final userId =
            await authRepo.logIn(username: username, password: password);
        emit(
          AuthStateLogIn(
            username: username,
            password: password,
            formStatus: SubmissionSuccess(),
          ),
        );
        authCubit.launchSession(
            AuthCredentials(username: username, password: password));
      } on Exception catch (e) {
        emit(AuthStateLogIn(formStatus: SubmissionFailed(e)));
      }
    });
    on<AuthEventLogOut>((event, emit) async {
      emit(AuthStateSignOut(formStatus: FormSubmitting()));
      try {
        await authRepo.signOut();
        emit(
          AuthStateSignOut(
            formStatus: SubmissionSuccess(),
          ),
        );
        authCubit.terminateSession();
        authCubit.showLogin();
      } on Exception catch (e) {
        emit(AuthStateSignOut(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
