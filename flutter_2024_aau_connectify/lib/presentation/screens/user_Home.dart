import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/application/announcement/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/generalcubit/general_cubit.dart';
import 'package:flutter_2024_aau_connectify/application/role/role_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/Admin/admin.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/announcement_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/profile/user_profile.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  final List<BottomNavigationBarItem> _bottomNavBarUser = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Announcement',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
  final List<BottomNavigationBarItem> _bottomNavBarAdmin = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Announcement',
    ),
    const BottomNavigationBarItem(
      key:Key('profile'),
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    const BottomNavigationBarItem(
      key: Key('admin_page'),
      icon: Icon(Icons.admin_panel_settings),
      label: 'Admin',
    ),
  ];
  List<Widget> pageAdmins = [
    const AnnouncementUserPage(),
    const ProfileUser(
        name: 'John Doe',
        id: '123456',
        userName: 'johndoe',
        fieldOfStudy: 'Computer Science',
        image: 'assets/images/background_3.jpeg'),
    AdminPage()
  ];
  List<Widget> pageUser = [
    const AnnouncementUserPage(),
    const ProfileUser(
        name: 'John Doe',
        id: '123456',
        userName: 'johndoe',
        fieldOfStudy: 'Computer Science',
        image: 'assets/images/background_3.jpeg'),
    const Placeholder()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralCubit, GeneralState>(
      builder: (context, state) {
        return BlocListener<RoleBloc, RoleState>(
          listener: (context, state) {
            if (state is UserData) {
              context.read<GeneralCubit>().setRole(state.role);
              context.read<GeneralCubit>().setUserId(state.userId);
            }
          },
          child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
            builder: (context, state) {
              return BlocBuilder<GeneralCubit, GeneralState>(
                builder: (context, state) {
                  return Scaffold(
                      appBar: AppBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        title: Text(
                          'AAU Connectify',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: CustomColors.secondaryTextColor),
                        ),
                        centerTitle: true,
                      ),
                      bottomNavigationBar: BottomNavigationBar(
                        selectedItemColor: CustomColors.primaryColor,
                        items: context.watch<GeneralCubit>().role == 'user'
                            ? _bottomNavBarUser
                            : _bottomNavBarAdmin,
                        currentIndex:
                            context.read<GeneralCubit>().navigationIndex,
                        onTap: (val) {
                          context.read<GeneralCubit>().setNavigationIndex(val);
                        },
                      ),
                      body: context.watch<GeneralCubit>().role == 'user'
                          ? pageUser[
                              context.watch<GeneralCubit>().navigationIndex]
                          : pageAdmins[
                              context.watch<GeneralCubit>().navigationIndex]);
                },
              );
            },
          ),
        );
      },
    );
  }
}
