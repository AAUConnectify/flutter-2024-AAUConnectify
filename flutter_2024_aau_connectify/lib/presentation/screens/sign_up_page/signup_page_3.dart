import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/announcement%20page/announcement_user.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/user_Home.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart'
    as route;
import 'package:flutter_2024_aau_connectify/presentation/widgets/text_field.dart';

// ignore: must_be_immutable
class SignUp3 extends StatelessWidget {
  String email;
  SignUp3({super.key, String? email}) : email = email ?? 'Error: No email provided.';
  final TextEditingController _verifyEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
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
                  child: Text('verification code is sent to your email address',
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
                      TextFieldCustom(countroller: _verifyEmail, label: 'verification code'),
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
                    if (formKey.currentState!.validate()) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
