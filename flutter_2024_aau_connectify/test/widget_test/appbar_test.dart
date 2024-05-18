import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/appbar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("tesing the Custom appaBar Widget  ", () {
    testWidgets('appbar ...', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Title',
              actions: const [],
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
    });

    //add action to appbar and check if it is displayed
    testWidgets('appbar with action ...', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Title',
              actions: const [Icon(Icons.add)],
            ),
          ),
        ),
      );
      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
