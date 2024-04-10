// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/bloc/announcement_bloc/announcement_bloc.dart';
import 'package:flutter_2024_aau_connectify/bloc/generalcubit/general_cubit.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/Admin/admin.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/announcement_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/profile/user_profile.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Announcement',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.admin_panel_settings),
      label: 'Admin',
    ),
  ];
  List pages = [
    const AnnouncementUserPage(),
    const ProfileUser(
        name: 'John Doe',
        id: '123456',
        userName: 'johndoe',
        fieldOfStudy: 'Computer Science',
        image: 'assets/images/background_3.jpeg'),
    AdminPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementBloc, AnnouncementState>(
      builder: (context, state) {
        return BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  items: _bottomNavBarItems,
                  currentIndex: context.read<GeneralCubit>().navigationIndex,
                  onTap: (int) {
                    context.read<GeneralCubit>().setNavigationIndex(int);
                  },
                ),
                body: pages[context.read<GeneralCubit>().navigationIndex]);
          },
        );
      },
    );
  }
}
