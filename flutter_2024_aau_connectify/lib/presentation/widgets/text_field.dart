import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';

class TextFieldCustom extends StatelessWidget {
   TextFieldCustom(
      {super.key, required this.countroller, required this.label, bool? isPass})
      :isPass = isPass ?? false;
  final TextEditingController countroller;
  final String label;
   bool isPass;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: CustomPaddings.small),
      child: TextFormField(
        obscureText: isPass,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required, please fill it out.';
          }
          return null;
        },
        decoration: InputDecoration(
            //if isPass is true, show icon to toggle password visibility
            suffixIcon: isPass
                ? IconButton(
                    icon: Icon(
                        isPass ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      isPass = !isPass;
                    })
                : null,

            contentPadding: const EdgeInsets.only(left: CustomPaddings.medium),
            label: Text(label)),
        controller: countroller,
      ),
    );
  }
}
