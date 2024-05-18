import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/landing_page_main_component.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('landing page main component ...', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LandingPageMainComponent(),
      ),
    ));
    expect(find.byType(LandingPageMainComponent), findsOneWidget);
    expect(find.text('Welcome to AAU Connectify'), findsOneWidget);

  });
}