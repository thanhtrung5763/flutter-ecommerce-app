import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/route_helper.dart';
import 'package:final_project/services/auth/auth_navigator.dart';
import 'package:final_project/services/auth/auth_repository.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/services/repo/user_repository.dart';
import 'package:final_project/theme.dart';
import 'package:final_project/views/home/cubit/session_cubit.dart';
import 'package:final_project/views/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'amplifyconfiguration.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')], path: 'assets/translations', fallbackLocale: const Locale('en', 'US'), child: const MyApp(),),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: _isAmplifyConfigured
          ? MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => AuthRepository(),
                ),
                RepositoryProvider(
                  create: (context) => UserRepository(),
                ),
              ],
              child: BlocProvider(
                create: (context) => SessionCubit(
                  authRepository: context.read<AuthRepository>(),
                  userRepository: context.read<UserRepository>(),
                ),
                child: AppNavigator(),
              ),
            )
          : Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
      routes: RouteHelper.routes,
    );
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAPI(modelProvider: ModelProvider.instance),
      ]);

      await Amplify.configure(amplifyconfig);

      setState(() {
        _isAmplifyConfigured = true;
      });

      print(_isAmplifyConfigured);
    } catch (e) {
      print(e);
    }
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        if (state is UnknownSessionState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is Unauthenticated) {
          return BlocProvider(
            create: (context) =>
                AuthCubit(sessionCubit: context.read<SessionCubit>()),
            child: const AuthNavigator(),
          );
        } else if (state is Authenticated) {
          return BlocProvider(
            create: (context) =>
                AuthCubit(sessionCubit: context.read<SessionCubit>()),
            child: const MainView(),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
