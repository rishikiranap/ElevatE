import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ElevatE/Screens/liked_quotes_page.dart'; // Import the LikedQuotesPage file

void main() {
  testWidgets('LikedQuotesPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LikedQuotesPage(),
      ),
    );

    // Test 1: Expect to find the app bar title
    expect(find.text('Liked Quotes'), findsOneWidget);
  });
}
