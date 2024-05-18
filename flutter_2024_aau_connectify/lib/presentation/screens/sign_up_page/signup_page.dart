import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_2024_aau_connectify/application/auth/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/radiuses.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _studentPasswordController =
      TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final customtext = Theme.of(context).textTheme;
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationStudentVerified) {
          debugPrint(
              "Student Verified Successfully, moving to account creation page.");
          
          context.go( signupRoute2, extra: {
            'studentId': _idController.text,
            'studentPassword': _studentPasswordController.text
          } );
        }
        if (state is AuthenticationFailure) {
          debugPrint("Error: ${state.error}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: CustomColors.errorColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: CustomPaddings.small),
                child: CircleAvatar(
                  backgroundColor: CustomColors.backgroundColor,
                  radius: CustomRadius.ultimateLarge,
                  backgroundImage: AssetImage('assets/images/aau_logo.png'),
                ),
              ),
              Text(
                "AAU Connectify",
                style: customtext.headlineSmall,
              ),
              const SizedBox(
                height: CustomPaddings.extraLarge,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: CustomPaddings.small),
                child: Text(
                  textAlign: TextAlign.center,
                  "Please Enter your School ID and Password to verify your identity.",
                  style: customtext.bodyLarge,
                ),
              ),
              const SizedBox(
                height: CustomPaddings.extraLarge,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CustomPaddings.medium),
                  child: ListView(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFieldCustom(
                                countroller: _idController, label: 'ID'),
                            TextFieldCustom(
                              countroller: _studentPasswordController,
                              label: 'Student Password',
                              isPass: true,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return FractionallySizedBox(
                        widthFactor: 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint("pressed");
                            if (formKey.currentState!.validate()) {
                              // If the form is valid, display a Snackbar.
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  CheckStudent(
                                      studentId: _idController.text,
                                      studentPassword:
                                          _studentPasswordController.text));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.primaryColor,
                            foregroundColor: CustomColors.backgroundColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: const TextStyle(
                              fontFamily: FontFamily.primary,
                              fontSize: CustomFontSize.h4,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.backgroundColor,
                            ),
                          ),
                          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              if (state is AuthenticationLoading) {
                                return const CircularProgressIndicator(
                                  color: CustomColors.backgroundColor,
                                  value: null ,
                                  semanticsLabel: 'Loading' ,
                                  strokeWidth: 2.0 ,
                                  

                                );
                              }
                              return const Text('Verify identity');
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: CustomPaddings.small,
                  ),
                  // Registration option
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: CustomPaddings.ultraLarge),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                            onPressed: () => (context.go(loginRoute)),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: CustomColors.primaryColor,
                                  fontSize: CustomFontSize.h6,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
      },
    );
  }
}
