import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cgpa/main.dart';

void main() {
  testWidgets('GPA Calculator adds a subject and calculates GPA', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GPAApp());

    // Tap the "GPA Calculator" button to navigate to GPA screen.
    await tester.tap(find.text('GPA Calculator'));
    await tester.pumpAndSettle();

    // Enter subject name.
    await tester.enterText(find.byType(TextField).first, 'Math');

    // Tap the "Add Subject" button.
    await tester.tap(find.text('Add Subject'));
    await tester.pump();

    // Verify subject was added.
    expect(find.text('Math'), findsOneWidget);

    // Tap "Calculate GPA" button.
    await tester.tap(find.text('Calculate GPA'));
    await tester.pump();

    // Verify GPA text is shown
    expect(find.textContaining('Your GPA:'), findsOneWidget);
  });
}
