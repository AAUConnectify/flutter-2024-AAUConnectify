import 'package:flutter/material.dart';
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
    
    testWidgets('End to end Interation test by cheking all the app and navigating throught the app and then logout', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      //find the email and password textfield and enter the email and password
      await tester.enterText(find.byType(TextFormField).at(0), 'fuad.mohammed@a2sv.org');
      await tester.enterText(find.byType(TextFormField).at(1),'pass');
      //find the login button and tap it
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2) );

      print('Successfully logged in');

  //got to admin page
      await tester.tap(find.byKey(const Key('admin_page')));
      await tester.pumpAndSettle();

      //got to manage Annaouncement
      await tester.tap(find.byKey(const Key('manage_announcement')));
      await tester.pumpAndSettle();

      //create announcement
      await tester.tap(find.byKey(const Key('create_announcement_button')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      //enter the title, date, summery, content and image
      await tester.enterText(find.byKey(const Key('title_field')), 'This is Title from Integration Test');
      await tester.enterText(find.byKey(const Key('date_field')), '2022-12-12');
      await tester.enterText(find.byKey(const Key('summery_field')), 'This is Summery from Integration Test');
      await tester.enterText(find.byKey(const Key('content_field')), 'This is Content from Integration Test');
      await tester.enterText(find.byKey(const Key('image_field')), 'https://testsigma.com/blog/wp-content/uploads/In-article-MC410.jpg');
      await tester.tap(find.byKey(const Key('finish_create_announcement_button')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      print('Successfully created an announcement');
      //got back manage announcement
      await tester.tap(find.byKey(const Key('back_button_from_create_announcement')));
      await tester.pumpAndSettle();
      //got to manage users
      await tester.tap(find.byKey(const Key('manage_users_page')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      //got back manage Admin
      await tester.tap(find.byKey(const Key('manage_admins_page')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      //got to manage Annaouncement
      await tester.tap(find.byKey(const Key('manage_announcement')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      //delete the announcement
      await tester.tap(find.byKey(const Key('delete_announcement')).at(1));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      print('Successfully deleted an announcement'); 

      //got to announcement page
      await tester.tap(find.byKey(const Key('announcement_page'),));
      await tester.pumpAndSettle();

      //got to annoucement read more
      await tester.tap(find.byKey(const Key('Announcement_read_more_button')).at(0));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      //add a comment
      await tester.enterText(find.byKey(const Key('comment_field')), 'This is a comment from Integration Test');
      await tester.tap(find.byKey(const Key('post_comment_button')));
      await tester.pumpAndSettle();

      print('Successfully added a comment');
      await Future.delayed(const Duration(seconds: 2));

      // edit the comment
      await tester.tap(find.byKey(const Key('edit_comment_button')).at(0));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));

      await tester.enterText(find.byKey(const Key('comment_edit_textfield')), 'This is an edited comment from Integration Test');
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('update_comment_button')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      print('Successfully edited a comment');

      //got back to announcement page
      await tester.tap(find.byKey(const Key('back_button_from_announcement_detail')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
 
      //got to profile
      await tester.tap(find.byKey(const Key('profile')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      //got to logout
      await tester.tap(find.byKey(const  Key('logout_button')));
      await tester.pumpAndSettle();
      //expect to find Home page
    });
  });

} 


/* 
import 'package:flutter/material.dart';
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
    testWidgets('Start App and Login', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsWidgets);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Enter email and password
      await tester.enterText(find.byType(TextFormField).at(0), 'fuad.mohammed@a2sv.org');
      await tester.enterText(find.byType(TextFormField).at(1), 'pass');

      // Tap login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      print('Successfully logged in');
    });

    testWidgets('Navigate to Admin Page and Manage Announcements', (WidgetTester tester) async {
      // Assuming the app is already logged in
      await tester.tap(find.byKey(const Key('admin_page')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('manage_announcement')));
      await tester.pumpAndSettle();

      // Create announcement
      expect(find.byKey(const Key('create_announcement_button')), findsOneWidget);
      await tester.tap(find.byKey(const Key('create_announcement_button')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('title_field')), 'This is Title from Integration Test');
      await tester.enterText(find.byKey(const Key('date_field')), '2022-12-12');
      await tester.enterText(find.byKey(const Key('summery_field')), 'This is Summery from Integration Test');
      await tester.enterText(find.byKey(const Key('content_field')), 'This is Content from Integration Test');
      await tester.enterText(find.byKey(const Key('image_field')), 'https://testsigma.com/blog/wp-content/uploads/In-article-MC410.jpg');
      await tester.tap(find.byKey(const Key('finish_create_announcement_button')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      print('Successfully created an announcement');

      // Navigate back
      await tester.tap(find.byKey(const Key('back_button_from_create_announcement')));
      await tester.pumpAndSettle();
    });

    testWidgets('Manage Users and Admins', (WidgetTester tester) async {
      // Assuming the app is on the Admin page
      await tester.tap(find.byKey(const Key('manage_users_page')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      print('Successfully navigated to Manage Users');

      await tester.tap(find.byKey(const Key('manage_admins_page')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      print('Successfully navigated to Manage Admins');
    });

    testWidgets('Delete Announcement and Logout', (WidgetTester tester) async {
      // Assuming the app is on the Admin page
      await tester.tap(find.byKey(const Key('manage_announcement')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));

      // Delete the announcement
      await tester.tap(find.byKey(const Key('delete_announcement')).at(1));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 2));
      print('Successfully deleted an announcement');

      // Navigate to profile and logout
      await tester.tap(find.byKey(const Key('profile')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('logout_button')));
      await tester.pumpAndSettle();

      // Expect to find Home page
      expect(find.byType(LandingPageMainComponent), findsOneWidget);
      print('Successfully logged out and returned to the home page');
    });
  });
}
 */