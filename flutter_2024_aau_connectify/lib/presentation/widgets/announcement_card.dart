import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_2024_aau_connectify/presentation/navigation/route.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/colors.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/heights.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/widths.dart';

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String images;
  final DateTime date;
  final String summary;
  final String id;
  const AnnouncementCard(
      {super.key,
      required this.id,
      required this.title,
      required this.images,
      required this.date,
      required this.summary});

  @override
  Widget build(BuildContext context) {
    return Card(
        // design best announcment card
        margin: const EdgeInsets.all(CustomPaddings.small),
      
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold,color: CustomColors.primaryTextColor)),
            Text(
              date.toString().substring(0, 11),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            ),
            Image.network(
              images,
              height: CustomImageHeights.imagesSmall,
              width: CustomImageWidths.imagesSmall,
            ),
            Text(
              summary,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
            ),
            Container(
                margin: const EdgeInsets.all(CustomPaddings.small),
                child: ElevatedButton(
                    onPressed: () {
                      context
                          .push(announcementDetailUserRoute, extra: {'id': id});
                    },
                    style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                          minimumSize: const MaterialStatePropertyAll(
                              Size(double.infinity, ButtonHeights.large)),
                        ),
                    child: const Text('Read More'))),
          ]),
        ));
  }
}
