import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/bloc/generalcubit/general_cubit.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: constant_identifier_names
const List<String> announcement_categories = [
  "All",
  "Academic",
  "Research",
  "Events",
  "Notices",
  "Internship",
  "Career",
  "Other"
];

class AnnouncementCatagory extends StatelessWidget {
  const AnnouncementCatagory({super.key});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: announcement_categories.length,
          itemBuilder: (context, index) {
            return TextButton(
              onPressed: () {
                context.read<GeneralCubit>().setCategory(index);
              },
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(index == context.watch<GeneralCubit>().category
                    ? Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: CustomColors.primaryColor)
                    : Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: CustomColors.secondaryTextColor)),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll(
                    index == context.watch<GeneralCubit>().category
                        ? CustomColors.primaryColor
                        : Theme.of(context).colorScheme.background),
                elevation: MaterialStatePropertyAll(
                    index == context.watch<GeneralCubit>().category ? 23 : 1),
              ),
              child: Text(
                announcement_categories[index],
              ),
            );
          }),
    );
  }
}
