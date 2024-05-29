import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/data_providers/user_data_provider.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/theme/custom_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(AAUConnectifyApp(theme: theme));
}

class AAUConnectifyApp extends StatelessWidget {
  final ThemeData theme;

  const AAUConnectifyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(UserDataProvider()),
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: MaterialApp.router(
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          theme: theme,
        ),
      ),
    );
  }
}