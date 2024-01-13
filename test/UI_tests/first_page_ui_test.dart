import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ElevatE/Screens/first_page.dart';

void main() {
  testWidgets('FirstPage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: FirstPage(quotes: [])));

    // Test 1: Verify the presence of the app bar title and logo
    expect(find.text('ElevatE'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Test 2: Verify the presence of mood buttons
    expect(find.byType(OutlinedButton), findsWidgets);
    expect(find.text('😂'), findsOneWidget); // Adjust as needed

    // Test 4: Verify the presence of bottom navigation bar items
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });
}
