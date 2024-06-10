import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/bloc/user_bloc/user_bloc.dart';
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
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(UserPromote(id));
            },
            child: const Text('Promote to Admin'),
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
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(AdminDemote(id));
            },
            child: const Text('Demote to User'),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
