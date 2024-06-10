import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2024_aau_connectify/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/models/user_model.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/user_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageUsers extends StatelessWidget {
  ManageUsers({super.key});


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(GetUserDetails());
    return Column(children: [
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
                    );
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
    ]);
  }
}
