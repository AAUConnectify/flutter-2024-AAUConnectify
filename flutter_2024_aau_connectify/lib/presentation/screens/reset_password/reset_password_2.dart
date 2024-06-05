import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/heights.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/radiuses.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/widths.dart';

class ResetPasswordPage2 extends StatefulWidget {
  const ResetPasswordPage2({super.key});

  @override
  State<ResetPasswordPage2> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage2> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _passwordsMatch = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _resetPassword() {
    setState(() {
      _passwordsMatch = _newPasswordController.text == _confirmPasswordController.text;
    });

    if (_passwordsMatch) {
      // Implement the reset password logic here
      // Navigator.pushNamed(context, route.someRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(CustomPaddings.large),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reset Your Password",
                    style: _textTheme.titleLarge!.copyWith(fontSize: CustomFontSize.h3),
                  ),
                  const SizedBox(
                    height: CustomPaddings.medium,
                  ),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "New Password",
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: CustomPaddings.small),
                        child: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: CustomColors.primaryColor,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(CustomPaddings.medium),
                    ),
                  ),
                  const SizedBox(
                    height: CustomPaddings.medium,
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      errorText: _passwordsMatch ? null : "Passwords do not match",
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: CustomPaddings.small),
                        child: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: CustomColors.primaryColor,
                          ),
                          onPressed: _toggleConfirmPasswordVisibility,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(CustomPaddings.medium),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: CustomPaddings.extraUltraLarge,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(ButtonWidths.extraLarge, ButtonHeights.large),
              ),
              onPressed: _resetPassword,
              child: Text(
                "Reset",
                style: _textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
