import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/application/generalcubit/general_cubit.dart';
import 'package:flutter_2024_aau_connectify/application/user/user_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String id;

  const UserCard(
      {super.key, required this.email, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/background_3.jpeg'),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: CustomFontSize.h4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: CustomFontSize.caption,
                      color: CustomColors.textGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          //add a full width button that says promote to admin
          BlocBuilder<GeneralCubit, GeneralState>(
            builder: (context, state) {
              if (state is GeneralStats && state.role == 'superadmin') {
                return ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context).add(UserPromote(id));
                  },
                  child: const Text('Promote to Admin'),
                );
              } else {
                return Container();
              }
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final String name;
  final String email;
  final String id;

  const AdminCard(
      {super.key, required this.email, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/background_3.jpeg'),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: CustomFontSize.h4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: CustomFontSize.caption,
                      color: CustomColors.textGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          //add a full width button that says promote to admin
          BlocBuilder<GeneralCubit, GeneralState>(
            builder: (context, state) {
              if (state is GeneralStats && state.role == 'superadmin') {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context).add(AdminDemote(id));
                  },
                  child: const Text('Demote to User'),
                );
              } else {
                return Container();
              }
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
