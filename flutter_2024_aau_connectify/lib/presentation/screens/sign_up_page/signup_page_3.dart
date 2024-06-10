import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2024_aau_connectify/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/screens/announcement%20page/announcement_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/screens/user_Home.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart'
    as route;
import 'package:flutter_2024_aau_connectify/presentation/widgets/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class SignUp3 extends StatelessWidget {
  String email;
  SignUp3({super.key, String? email})
      : email = email ?? 'Error: No email provided.';
  final TextEditingController _verifyEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.pop(context);
            },
          ),
        ),
        body: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 20, left: 40),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text('vefication code is sent to : $email ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w600)),
                    )),
                Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                        'verification code is sent to your email address',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.w600))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomPaddings.medium),
                    child: ListView(
                      children: [
                        ///addition info for the user
                        TextFieldCustom(
                            countroller: _verifyEmail,
                            label: 'verification code'),
                        //create a list of secret questions for the user to choose from and answer
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            VerifyEmail(email: email, code: _verifyEmail.text));
                      
                    },
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                            minimumSize: const MaterialStatePropertyAll(
                                Size(double.infinity, 50))),
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is AuthenticationLoading){
                          return const CircularProgressIndicator();
                        }
                        return Text(
                          "Verify Email",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
