/*
import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/announcement_detail_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/announcement_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/create_announcement.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/landing_page.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/login_page.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/reset_password/reset_password.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/reset_password/reset_password_2.dart';

import 'package:flutter_2024_aau_connectify/presentation/screens/sign_up_page/signup_page.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/sign_up_page/signup_page_2.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/user_Home.dart';

import '../screens/profile/user_profile.dart';

const String loginRoute = '/login_page';
const String homeRoute = '/home_page';
const String signupRoute = '/signup_page';
const String signupRoute2 = '/signup_page2';
const String landingpageRoute = '/landingpage_page';
const String announcementUser = '/Announcement_user_page';
const String profileUser = '/profile_user_page';
const String resetPasswordRoute = '/reset_password_page';
const String resetPasswordRoute2 = '/reset_password_page2';
const String announcementDetailUserRoute = '/announcement_detail_user';
const String createAnnouncementRoute = '/create_announcement';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case landingpageRoute:
      return MaterialPageRoute(builder: (context) => const LandingPage());
    case homeRoute:
      return MaterialPageRoute(builder: (context) => const Home());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case signupRoute:
      return MaterialPageRoute(builder: (context) => const SignUp());
    case signupRoute2:
      return MaterialPageRoute(builder: (context) => SignUp2());
    case announcementUser:
      return MaterialPageRoute(
          builder: (context) => const AnnouncementUserPage());
    case profileUser:
      return MaterialPageRoute(
          builder: (context) => const ProfileUser(
              name: 'John Doe',
              id: '123456',
              userName: 'johndoe',
              fieldOfStudy: 'Computer Science',
              image: 'assets/images/profile.jpg'));

    case resetPasswordRoute:
      return MaterialPageRoute(builder: (context) => const ResetPasswordPage());
    case resetPasswordRoute2:
      return MaterialPageRoute(
          builder: (context) => const ResetPasswordPage2());
    case announcementDetailUserRoute:
      return MaterialPageRoute(
          builder: (context) => const AnnouncementDetailUser());
    
    case createAnnouncementRoute:
      return MaterialPageRoute(
          builder: (context) =>  CreateAnnouncement(title: 'how can we have a time ',summery: 'how can we have a time how can we have a time how can we have a time ',tag: 'Events', ));
    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}
*/

import 'package:flutter_2024_aau_connectify/application/announcement/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/role/role_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/create_announcement.dart'
    as screens;
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/update_announcement.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/sign_up_page/signup_page_3.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/sign_up_page/signup_page_4.dart';
import 'package:flutter_2024_aau_connectify/infrastructure/repository/announcement_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/announcement_detail_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/announcement_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/landing_page.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/login_page.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/reset_password/reset_password.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/reset_password/reset_password_2.dart';

import 'package:flutter_2024_aau_connectify/presentation/screens/sign_up_page/signup_page.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/sign_up_page/signup_page_2.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/user_Home.dart';

import '../screens/profile/user_profile.dart';

const String loginRoute = '/login_page';
const String homeRoute = '/home_page';
const String signupRoute = '/landingpage_page/signup_page';
const String signupRoute2 = '/landingpage_page/signup_page/signup_page2';
const String signupRoute3 =
    '/landingpage_page/signup_page/signup_page2/signup_page3';
const String signupRoute4 =
    '/landingpage_page/signup_page/signup_page2/signup_page3/signup_page4';
const String landingpageRoute = '/landingpage_page';
const String announcementUser = '/Announcement_user_page';
const String profileUser = '/profile_user_page';
const String resetPasswordRoute = '/login_page/reset_password_page';
const String resetPasswordRoute2 =
    '/login_page/reset_password_page/reset_password_page2';
const String announcementDetailUserRoute = '/announcement_detail_user';
const String createAnnouncementRoute = '/create_announcement';
const String updateAnnouncementRoute = '/update_announcement';

class AppRouter {
  static final router = GoRouter(
    initialLocation: landingpageRoute,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const Scaffold(
        body: Center(
          // ...

          child: Text('No route defined for '),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: landingpageRoute,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: homeRoute,
        builder: (context, state) {
          BlocProvider.of<RoleBloc>(context).add(RoleStatus());
          return BlocProvider(
            create: (context) => AnnouncementBloc(
              announcementRepository: context.read<AnnouncementRepository>(),
            )..add(const FetchAnnouncements(1, 10)),
            child: Home(),
          );
        },
      ),
      GoRoute(
        path: loginRoute,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: signupRoute,
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: signupRoute2,
        builder: (context, state) {
          final studentId =
              (state.extra as Map<String, dynamic>)['studentId'] as String? ??
                  '';
          final studentPassword = (state.extra
                  as Map<String, dynamic>)['studentPassword'] as String? ??
              '';
          return SignUp2(
              studentId: studentId, studentPassword: studentPassword);
        },
      ),
      GoRoute(
        path: signupRoute3,
        builder: (context, state) {
          final email =
              (state.extra as Map<String, dynamic>)['email'] as String? ?? '';
          return SignUp3(email: email);
        },
      ),
      GoRoute(
        path: signupRoute4,
        builder: (context, state) {
          return ProfilePage();
        },
      ),
      GoRoute(
        path: announcementUser,
        builder: (context, state) => const AnnouncementUserPage(),
      ),
      GoRoute(
        path: profileUser,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return ProfileUser(
            name: data?['name'] ?? 'John Doe',
            id: data?['id'] ?? '123456',
            userName: data?['userName'] ?? 'johndoe',
            fieldOfStudy: data?['fieldOfStudy'] ?? 'Computer Science',
            image: data?['image'] ?? 'assets/images/profile.jpg',
          );
        },
      ),
      GoRoute(
        path: resetPasswordRoute,
        builder: (context, state) => ResetPasswordPage(),
      ),
      GoRoute(
        path: resetPasswordRoute2,
        builder: (context, state) => const ResetPasswordPage2(),
      ),
      GoRoute(
        path: announcementDetailUserRoute,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return BlocProvider(
            create: (context) => AnnouncementBloc(
              announcementRepository: context.read<AnnouncementRepository>(),
            )..add(FetchAnnouncementById(id: (data?['id'] ?? ''))),
            child: AnnouncementDetailUser(
              id: data?['id'] ?? 'Default ID',
            ),
          );
        },
      ),
      GoRoute(
        path: createAnnouncementRoute,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return screens.CreateAnnouncement(
            title: data?['title'] ?? '',
            content: data?['content'] ?? '',
            summery: data?['summery'] ?? '',
            date: data?['date'] ?? '',
            image: data?['image'] ?? '',
            tag: data?['tag'] ?? 'Academic',
          );
        },
      ),
      GoRoute(
        path: updateAnnouncementRoute,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return UpdateAnnouncements(
            title: data?['title'] ?? '',
            content: data?['content'] ?? '',
            summery: data?['summery'] ?? '',
            date: data?['date'] ?? '',
            image: data?['image'] ?? '',
            tag: data?['tag'] ?? 'Academic',
            id: data?['id'] ?? '',
          );
        },
      ),
    ],
  );
}
