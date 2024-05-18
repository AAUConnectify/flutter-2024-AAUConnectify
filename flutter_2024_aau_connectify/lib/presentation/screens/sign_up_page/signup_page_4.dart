import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _studyController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationEmailVerified) {
          context.go(homeRoute);
        }
        if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: CustomColors.errorColor,
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your profile information',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 40),
              TextFieldCustom(
                  countroller: _fullNameController, label: 'Full Name'),
              const SizedBox(height: 10),
              TextFieldCustom(
                  countroller: _studyController, label: 'Field of Study'),
              const SizedBox(height: 10),
              TextFieldCustom(countroller: _bioController, label: 'Bio'),
              const SizedBox(height: 10),
              TextFieldCustom(
                  countroller: _profilePictureController,
                  label: 'Profile Picture'),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                ) ,
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(CreateProfile(
                    fullName: _fullNameController.text,
                    fieldOfStudy: _studyController.text,
                    bio: _bioController.text,
                    profilePicture: _profilePictureController.text,
                  ));
                },
                child:  Text('Submit', style: Theme.of(context).textTheme.titleLarge ,),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
