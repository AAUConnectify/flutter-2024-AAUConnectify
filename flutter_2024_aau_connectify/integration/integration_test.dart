import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/screens/user_Home.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/landing_page_main_component.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_2024_aau_connectify/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Initialize shared_preferences with mock values
    SharedPreferences.setMockInitialValues({});
  });

  group('Integration Test', () {
    /* testWidgets('Open the App navigate to login Screen and Enter Login data and Navigate to Home Page', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(Text), findsWidgets);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      //find the email and password textfield and enter the email and password
      await tester.enterText(find.byType(TextFormField).at(0), 'fuad.mohammed@a2sv.org');
      await tester.enterText(find.byType(TextFormField).at(1),'pass');
      //find the login button and tap it
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();
      //expect to find Home page
      expect(find.byType(Home), findsOneWidget);
    }); */
    testWidgets('Logout After the login of the home page', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(Text), findsWidgets);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      //find the email and password textfield and enter the email and password
      await tester.enterText(find.byType(TextFormField).at(0), 'fuad.mohammed@a2sv.org');
      await tester.enterText(find.byType(TextFormField).at(1),'pass');
      //find the login button and tap it
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2) );

      await tester.tap(find.byKey(const Key('profile')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('logout_button')));
      await tester.pumpAndSettle();
      //expect to find Home page
      expect(find.byType(LandingPageMainComponent), findsOneWidget);
    });
  });

}
