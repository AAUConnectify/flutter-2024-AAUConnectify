
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_2024_aau_connectify/application/auth/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/heights.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/radiuses.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/widths.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if(state is AuthenticationAuthenticated){
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: CustomPaddings.large),
                    child: Column(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(bottom: CustomPaddings.small),
                          child: CircleAvatar(
                            backgroundColor: CustomColors.backgroundColor,
                            radius: CustomRadius.ultimateLarge,
                            backgroundImage:
                                AssetImage('assets/images/aau_logo.png'),
                          ),
                        ),
                        Text(
                          "AAU Connectify",
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: CustomPaddings.large,
                        ),
                        Text(
                          "Login To Your Account",
                          style: textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.all(CustomPaddings.large),
                                child: Column(
                                  children: [
                                    TextFieldCustom(
                                      
                                      countroller: _emailController,
                                      label: 'Email',
                                      
                                    ),
                                    const SizedBox(
                                      height: CustomPaddings.medium,
                                    ),
                                    TextFieldCustom(
                                      key: const Key('password'),
                                      countroller: _passwordController,
                                      label: 'Password',
                                      isPass: true,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: CustomPaddings.large,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        context.push(resetPasswordRoute);
                                      },
                                      child: Text(
                                        "Forgot Password?",
                                        style: textTheme.labelLarge!.copyWith(
                                          color: CustomColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: CustomPaddings.small,
                                    ),
                                    ElevatedButton(
                                      key: const Key('login_button'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(
                                            ButtonWidths.extraLarge,
                                            ButtonHeights.large),
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(LoggedIn(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text));
                                      },
                                      child: BlocBuilder<AuthenticationBloc,
                                          AuthenticationState>(
                                        builder: (context, state) {
                                          if (state is AuthenticationLoading) {
                                            return const CircularProgressIndicator(
                                              color:
                                                  CustomColors.backgroundColor,
                                            );
                                          }
                                          return Text(
                                            "Login",
                                            style: textTheme.labelLarge,
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: CustomPaddings.small,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Don't have an account?"),
                                        TextButton(
                                            onPressed: () {
                                              context.go(signupRoute);
                                            },
                                            child: const Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                  color:
                                                      CustomColors.primaryColor,
                                                  fontSize: CustomFontSize.h6,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
