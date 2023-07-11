import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/routers/app_router.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/services/auth/auth_navigator.dart';
import 'package:final_project/services/auth/auth_repository.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/services/cloud/bloc/tracking_bloc.dart';
import 'package:final_project/services/repo/user_repository.dart';
import 'package:final_project/utils/theme.dart';
import 'package:final_project/views/home/cubit/session_cubit.dart';
import 'package:final_project/views/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:easy_localization/easy_localization.dart';


import 'amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51Lo1WDBGUwo1aZecZlLI32SNefJVQDYCU2y5C20qgWrcC7GGwSTxWEG0NKo3IvNRWf8kNzQWoKqub5ZQPiwxUzeY00pUw3kMpI';

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
    // const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  final _router = AppRouter();

  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: ScreenUtilInit(
          // designSize: const Size(393, 851),
          designSize: const Size(375, 812),
          builder: (context, child) {
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
                        child: const AppNavigator(),
                      ),
                    )
                  : const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
              // routes: RouteHelper.routes,
              // home: const StripePaymentScreen(),
              // home: TestStripeApiScreen(),
              // home: const MainTestView(),
              // home: const TestSnackBar(),
              // home: TestButtonSize(),
            );
          }),
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
            create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
            child: const AuthNavigator(),
          );
        } else if (state is Authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
              ),
              BlocProvider(
                create: (context) =>
                    state.isNewUser ? (TrackingBloc()..add(TrackingProductClearEvent())) : TrackingBloc(),
              ),
            ],
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
