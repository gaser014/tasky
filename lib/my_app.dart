import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/unit/app_themes.dart';
import 'package:tasky/feature/auth/register/bloc.dart';

import 'core/logic/get_it.dart';
import 'core/unit/routes.dart';
import 'feature/auth/login/bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => getIt<RegisterBloc>()),
        BlocProvider(create: (context) => getIt<LoginBloc>()),

      ],
      child:ScreenUtilInit(
        designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,

    builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0),),
    child: MaterialApp.router(

      title: 'Tasky',
    routerConfig: AppRouter.router,
    debugShowCheckedModeBanner: false,
    theme: getLightTheme(),
    ),
    ),
    ) ,

    );
  }
}
