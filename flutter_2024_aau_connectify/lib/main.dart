import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/application/announcement/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/auth/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/comment/comment_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/generalcubit/general_cubit.dart';
import 'package:flutter_2024_aau_connectify/application/role/role_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/user/user_bloc.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/announcement_data_provider.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/comment_data_provider.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/data_providers/user_data_provider.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/repository/announcement_repository.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/repository/comment_repository.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr =
      await rootBundle.loadString('assets/theme/custom_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(AAUConnectifyApp(theme: theme));
}

class AAUConnectifyApp extends StatelessWidget {
  final ThemeData theme;

  const AAUConnectifyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(UserDataProvider()),
        ),
        RepositoryProvider(
          create: (context) =>
              AnnouncementRepository(AnnouncementDataProvider()),
        ),
        RepositoryProvider(
          create: (context) =>
              CommentRepository(dataProvider: CommentDataProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            )..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => AnnouncementBloc(
              announcementRepository:
                  RepositoryProvider.of<AnnouncementRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => GeneralCubit(),
          ),
          BlocProvider(
            create: (context) =>
                UserBloc(RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider(
            create: (context) => RoleBloc(),
          ),
          BlocProvider(
              create: (context) => CommentBloc(
                    commentRepository:
                        RepositoryProvider.of<CommentRepository>(context),
                  ))
        ],
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
