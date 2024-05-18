import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_2024_aau_connectify/Domain/user_model.dart';
import 'package:flutter_2024_aau_connectify/application/auth/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/application/user/user_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/user_card.dart';

class ManageUsers extends StatelessWidget {
  const ManageUsers({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(GetUserDetails());
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserPromoteLoding) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Role change in Progress, Please wait ...'),
            duration:  Duration(seconds: 1),
            backgroundColor: CustomColors.textGrey,
          ));
        }
        if (state is UserPromoteFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              duration: const Duration(seconds: 1),
              backgroundColor: CustomColors.errorColor));
        }
        if (state is UserPromoteSucces) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Role change completed Successfuly'),
              duration:  Duration(seconds: 1),
              backgroundColor: CustomColors.primaryColor)
              );
          BlocProvider.of<AuthenticationBloc>(context).add(GetUserDetails());
        }
      },
      child: Column(children: [
        // a heading saying admins
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: CustomPaddings.large,
              vertical: CustomPaddings.extraLarge),
          child: Text(
            "Users",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),

        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                border: Border.symmetric(
              vertical: BorderSide(width: 1),
            )),
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              if (state is UserDetailLoaded) {
                final data = state.user;
                final List<User> users = [];
                for (var person in data) {
                  if (person.role == 'user') {
                    users.add(person);
                  }
                }
                if (users.isEmpty) {
                  return const Center(child: Text('No users found'));
                }
                return ListView.builder(
                  itemCount: users.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return UserCard(
                        email: users[index].email,
                        name: users[index].fullName,
                        id: users[index].id);
                  },
                );
              }
              if (state is UserLoadFailure) {
                return Center(
                    child: Column(
                  children: [
                    const Text('Failed to load users'),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(GetUserDetails());
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ));
              }

              return const Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      ]),
    );
  }
}
