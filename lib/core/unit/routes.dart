

import 'package:go_router/go_router.dart';
import 'package:tasky/core/logic/helper_methods.dart';
import 'package:tasky/view/onboarding/view.dart';
import 'package:tasky/view/splash/view.dart';

import '../../view/auth/login/view.dart';
import '../../view/auth/sing_up/sing_up.dart';

abstract class AppRouter {
 static const String rOnBoarding = '/on_boarding';
 static const String rLogIn = '/log_in';
 static const String rSignUp = '/sing_up';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),  GoRoute(
path: rOnBoarding,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: rLogIn,
        builder: (context, state) =>  LoginView(),
      ),
      GoRoute(
        path: rSignUp,
        builder: (context, state) => SingUpView (),),


    ],
  );
}
