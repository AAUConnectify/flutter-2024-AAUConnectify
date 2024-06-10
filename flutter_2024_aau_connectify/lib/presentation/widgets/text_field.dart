import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
    super.key,
    required this.countroller,
    required this.label,
    bool? isPass,
  }) : isPass = isPass ?? false;

  final TextEditingController countroller;
  final String label;
  final bool isPass;

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  late bool isPassVisible;

  @override
  void initState() {
    super.initState();
    isPassVisible = widget.isPass;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: CustomPaddings.small),
      child: TextFormField(
        obscureText: isPassVisible,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.label} is required, please fill it out.';
          }
          return null;
        },
        decoration: InputDecoration(
          // if isPass is true, show icon to toggle password visibility
          suffixIcon: widget.isPass
              ? IconButton(
                  icon: Icon(
                      isPassVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isPassVisible = !isPassVisible;
                    });
                  },
                )
              : null,
          contentPadding: const EdgeInsets.only(left: CustomPaddings.medium),
          label: Text(widget.label),
        ),
        controller: widget.countroller,
      ),
    );
  }
}
