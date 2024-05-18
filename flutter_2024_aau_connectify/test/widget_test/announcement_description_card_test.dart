import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/Domain/announcement_mode.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/announcement_description_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('announcement description card ...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AnnouncementDescriptionCard(
        
          announcement: Announcement(
            content: 'content',
            title: 'title',
            image: 'image',
            category: 'category',
            date: 'date',
            id: 'id',
            summary: 'summary',
            tag: 'tag',


          ),
        ),
      ),
    ));

    expect(find.text('content'), findsOneWidget);


  });
}