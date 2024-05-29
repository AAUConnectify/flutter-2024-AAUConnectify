import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2024_aau_connectify/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/announcement_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/user_Home.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart'
    as route;
import 'package:flutter_2024_aau_connectify/presentation/widgets/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUp2 extends StatelessWidget {
  String studentId;
  String studentPassword;
  SignUp2({super.key, String? studentId, String? studentPassword})
      : studentPassword = studentPassword ?? '',
        studentId = studentId ?? '';
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
       if (state is AuthenticationAccountCreated){
        context.go(signupRoute3, extra: {
          'email':_emailController.text
        });
       }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Expanded(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          'Enter your details below to create an account',
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
                          TextFieldCustom(
                              countroller: _emailController, label: 'Email'),
                          TextFieldCustom(
                              countroller: _fullNameController,
                              label: 'Full name'),
                          TextFieldCustom(
                              countroller: _newpassController,
                              label: 'New password',
                              isPass: true),
                          TextFieldCustom(
                              countroller: _confirmPassController,
                              label: 'Confirm password',
                              isPass: true),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const TextField(
                              decoration:
                                  InputDecoration(label: Text('Image link')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthenticationLoading) {
                        return const CircularProgressIndicator();
                      }
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            //cheack if the password match
                            if (_newpassController.text !=
                                _confirmPassController.text) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Passwords do not match'),
                                backgroundColor: CustomColors.errorColor,
                              ));
                            } else if (!formKey.currentState!.validate()) {
                            } else {
                              //get the email and password from the previous page as arguments

                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(Registered(
                                email: _emailController.text,
                                password: _newpassController.text,
                                studentId: studentId,
                                studentPassword: studentPassword,
                                fullName: _fullNameController.text,
                              ));
                            }
                          },
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  minimumSize: const MaterialStatePropertyAll(
                                      Size(double.infinity, 50))),
                          child: Text(
                            "create account",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
