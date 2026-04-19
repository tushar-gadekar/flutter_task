import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investor_app/application/auth/auth_bloc.dart';
import 'package:investor_app/infrastructure/auth/repository/auth_repositry.dart';
import 'package:investor_app/presentation/core/theme/app_theme.dart';
import 'package:investor_app/presentation/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthRepositry())..add(CheckSessionEvent()),
      child: MaterialApp(
        title: 'DealFlow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: BlocProvider(
          create: (_) => AuthBloc(AuthRepositry()),
          child: const SplashScreen(),
        ),
      ),
    );
  }
}