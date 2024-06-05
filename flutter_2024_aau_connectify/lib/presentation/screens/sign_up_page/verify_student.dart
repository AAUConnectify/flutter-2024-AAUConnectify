import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/radiuses.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart'
    as route;

class SignUpVerify extends StatefulWidget {
  const SignUpVerify({super.key});

  @override
  State<SignUpVerify> createState() => _SignUpVerifyState();
}


class _SignUpVerifyState extends State<SignUpVerify> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentPasswordController =
      TextEditingController();
  final TextEditingController _idController = TextEditingController();

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
              "Verify You are AAU's Student",
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
                          label: Text('Student ID')),
                      controller: _idController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: CustomPaddings.small),
                    child: TextField(
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: CustomPaddings.medium),
                          label: Text('Student Password')),
                      controller: _studentPasswordController,
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
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.pushNamed(context, route.signupRoute);
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
                  child: const Text('Verify'),
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
