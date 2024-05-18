import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/Domain/announcement_mode.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/paddings.dart';
import 'package:flutter_2024_aau_connectify/presentation/style/typography.dart';

class AnnouncementDescriptionCard extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementDescriptionCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.only(
                  top: CustomPaddings.medium,
                  bottom: CustomPaddings.small,
                  left: CustomPaddings.medium,
                  right: CustomPaddings.medium),
              child: Text(
                textAlign: TextAlign.justify,
                announcement.content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      );
    
  }
}
