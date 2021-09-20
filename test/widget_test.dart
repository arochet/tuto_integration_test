// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:integration_test_tutorial/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      "Not inputting a text and wanting to go to the display page shows "
      "an error and prevents from going to the display page.",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Input this text
    final inputText = 'Hello there, this is an input.';
    await tester.enterText(find.byKey(Key('your-text-field')), inputText);

    // Tap on a FAB
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // We should be in the DisplayPage that displays the inputted text
    expect(find.byType(TypingPage), findsNothing);
    expect(find.byType(DisplayPage), findsOneWidget);
    expect(find.text(inputText), findsOneWidget);

    // Tap on the back arrow in the AppBar
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // We should be back in the TypingPage and the previously inputted text
    // should be cleared out
    expect(find.byType(TypingPage), findsOneWidget);
    expect(find.byType(DisplayPage), findsNothing);
    expect(find.text(inputText), findsNothing);
  });
}
