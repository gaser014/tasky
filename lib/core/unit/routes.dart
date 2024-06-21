import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/logic/cashed_helper.dart';
import 'package:tasky/core/logic/helper_methods.dart';
import 'package:tasky/feature/auth/register/bloc.dart';
import 'package:tasky/view/home/view.dart';
import 'package:tasky/view/onboarding/view.dart';
import 'package:tasky/view/splash/view.dart';

import '../../feature/auth/login/bloc.dart';
import '../../feature/home/tasks/bloc.dart';
import '../../view/auth/login/view.dart';
import '../../view/auth/sing_up/sing_up.dart';
import '../logic/get_it.dart';

abstract class AppRouter {
  static const String rOnBoarding = '/on_boarding';
  static const String rLogIn = '/log_in';
  static const String rSignUp = '/sing_up';
  static const String rHome = '/home';
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            CachedHelper.isAuth() ? const SplashView() : const HomePageView(),
      ),
      GoRoute(
        path: rOnBoarding,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: rLogIn,
        builder: (context, state) => BlocProvider(
            create: (BuildContext context) {
              return getIt<LoginBloc>();
            },
            child: const LoginView()),
      ),
      GoRoute(
        path: rSignUp,
        builder: (context, state) => BlocProvider(
            create: (BuildContext context) {
              return getIt<RegisterBloc>();
            },
            child: const SingUpView()),
      ),
      GoRoute(
        path: rHome,
        builder: (context, state) => BlocProvider(
            create: (BuildContext context) {
              return getIt<TasksBloc>();
            },
            child: const HomePageView()),
      ),
    ],
  );
}
