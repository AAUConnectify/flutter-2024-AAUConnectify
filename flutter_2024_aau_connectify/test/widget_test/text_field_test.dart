import 'package:flutter/material.dart';
import 'package:flutter_2024_aau_connectify/presentation/widgets/text_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing Single Widget', () {
    testWidgets('text field ...', (tester) async {
      final TextEditingController controller = TextEditingController();
      const String label = 'Email';
      const bool isPassFalse = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextFieldCustom(
            countroller: controller,
            label: label,
            isPass: isPassFalse,
          ),
        ),
      ));

      expect(find.text(label), findsOneWidget);

      expect(find.byIcon(Icons.visibility_off), findsNothing);

    });

    testWidgets('check is the Widget shows the correct Icon', (tester) async {
      final TextEditingController controller = TextEditingController();
      const String label = 'Password';
      const bool isPassTrue = true;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextFieldCustom(
            countroller: controller,
            label: label,
            isPass: isPassTrue,
          ),
        ),
      ));

      expect(find.text(label), findsOneWidget);

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('check if the password visibility is toggled', (tester) async {
      final TextEditingController controller = TextEditingController();
      const String label = 'Password';
      const bool isPassTrue = true;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextFieldCustom(
            countroller: controller,
            label: label,
            isPass: isPassTrue,
          ),
        ),
      ));

      expect(find.text(label), findsOneWidget);

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('check if the password visibility is toggled', (tester) async {
      final TextEditingController controller = TextEditingController();
      const String label = 'Password';
      const bool isPassTrue = true;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextFieldCustom(
            countroller: controller,
            label: label,
            isPass: isPassTrue,
          ),
        ),
      ));

      expect(find.text(label), findsOneWidget);

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });


    //check the label is working and exists
    testWidgets('check if the label is working', (tester) async {
      final TextEditingController controller = TextEditingController();
      const String label = 'Password';
      const bool isPassTrue = true;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextFieldCustom(
            countroller: controller,
            label: label,
            isPass: isPassTrue,
          ),
        ),
      ));

      expect(find.text(label), findsOneWidget);
    });
  });
}
