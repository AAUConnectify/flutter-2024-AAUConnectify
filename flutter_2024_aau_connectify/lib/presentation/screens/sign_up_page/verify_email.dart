import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/radiuses.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final customtext = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CustomPaddings.ultimateLarge,
            horizontal: CustomPaddings.medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Verify Your Email",
                textAlign: TextAlign.center, style: customtext.headlineSmall),
            const SizedBox(height: CustomPaddings.ultimateLarge),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Code',
                    contentPadding: EdgeInsets.all(CustomPaddings.medium),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(CustomRadius.medium)),
                    ),
                  ),
                  controller: _codeController,
                ),
                const SizedBox(height: CustomPaddings.large),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your verify email logic here
                      Navigator.pushNamed(context, homeRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      foregroundColor: CustomColors.backgroundColor,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      textStyle: const TextStyle(
                        fontFamily: FontFamily.primary,
                        fontSize: CustomFontSize.h4,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.backgroundColor,
                      ),
                    ),
                    child: const Text('Verify Email'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
