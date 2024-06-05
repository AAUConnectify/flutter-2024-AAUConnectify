import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/radiuses.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart'
    as route;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentPasswordController =
      TextEditingController();
  final TextEditingController _studentPasswordConfirmController =
      TextEditingController();
  final TextEditingController _idController = TextEditingController();

  bool _passwordsMatch = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _createAccount() {
    setState(() {
      _passwordsMatch = _studentPasswordController.text ==
          _studentPasswordConfirmController.text;
    });

    if (_passwordsMatch) {
      Navigator.pushNamed(context, route.verifyEmailRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final customtext = Theme.of(context).textTheme;
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
            margin: const EdgeInsets.symmetric(vertical: CustomPaddings.small),
            child: Text(
              "Sign Up",
              style: customtext.titleLarge,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: CustomPaddings.medium),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: CustomPaddings.small),
                    child: TextField(
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: CustomPaddings.medium),
                          label: Text('Full Name')),
                      controller: _nameController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: CustomPaddings.small),
                    child: TextField(
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: CustomPaddings.medium),
                          label: Text('Email')),
                      controller: _usernameController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: CustomPaddings.small),
                    child: TextField(
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: CustomPaddings.medium),
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      controller: _studentPasswordController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: CustomPaddings.small),
                    child: TextField(
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: CustomPaddings.medium),
                        label: const Text('Confirm Password'),
                        errorText: _passwordsMatch
                            ? null
                            : 'Passwords do not match',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      controller: _studentPasswordConfirmController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                  onPressed: _createAccount,
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
                  child: const Text('Create Account'),
                ),
              ),
              const SizedBox(
                height: CustomPaddings.small,
              ),
              // Registration option
              Padding(
                padding:
                    const EdgeInsets.only(bottom: CustomPaddings.ultraLarge),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () =>
                            (Navigator.pushNamed(context, route.loginRoute)),
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
  }
}
