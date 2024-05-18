import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  List<Widget> actions;
  CustomAppBar({super.key, required this.title, required this.actions});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey, // You can set your desired border color here
              width: 0.5, // You can set the border width here
            ),
          ),
        ),
        child: AppBar(
          title: Text(title),
          actions: actions,
          leading: Padding(
            padding: const EdgeInsets.all(CustomPaddings.small),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left),
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
