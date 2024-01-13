import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ElevatE/Screens/loading_screen.dart';

void main() {
  testWidgets('LoadingScreen displays logo and loading indicator',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: LoadingScreen(),
      ),
    );

    // Verify that the logo is displayed.
    expect(find.byType(Image), findsOneWidget);

    // Verify that the loading indicator is displayed.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
