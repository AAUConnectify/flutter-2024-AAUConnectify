import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2024_aau_connectify/bloc/generalcubit/general_cubit.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/Admin/manage_admins.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/Admin/manage_announcement.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/Admin/manage_users.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/create_announcement.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/user_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});
  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      key: Key('manage_announcement'),
      icon: Icon(Icons.admin_panel_settings),
      label: 'Manage',
    ),
    const BottomNavigationBarItem(
      key: Key('manage_users_page'),
      icon: Icon(Icons.manage_accounts),
      label: 'Users',
    ),
    const BottomNavigationBarItem(
      key: Key('manage_admins_page'),
      icon: Icon(Icons.assignment_ind_outlined),
      label: 'Admin',
    ),
  ];
  final _pages = [
    const ManageAnnouncement(),
    const ManageUsers(),
    const ManageAdmins(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Container(
              color: Colors.grey[200],
              child: BottomNavigationBar(
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                items: _bottomNavBarItems,
                currentIndex: context.watch<GeneralCubit>().adminIndex,
                onTap: (int index) {
                  context.read<GeneralCubit>().setAdminIndex(index);
                },
              ),
            ),
            Expanded(
              child: _pages[context.watch<GeneralCubit>().adminIndex],
            ),
          ]),
        ],
      ),
    );
  }
}
