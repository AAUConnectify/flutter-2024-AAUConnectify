import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/heights.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/widths.dart';

class AnnouncementDetailImageCard extends StatelessWidget {
  final String image;
  const AnnouncementDetailImageCard({super.key, required this.image});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CustomImageWidths.imagesLarge,
      height: CustomImageHeights.imagesMedium,
      child: Card(
        child: Container(
          decoration:  BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image:  NetworkImage(image))),
        ),
      ),
    );
  }
}
