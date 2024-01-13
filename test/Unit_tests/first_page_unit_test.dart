import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ElevatE/Models/app_settings.dart'; // Replace with the actual path
import 'package:ElevatE/Screens/first_page.dart';
import 'package:provider/provider.dart';
import 'package:ElevatE/Screens/Quotes_Page.dart';

void main() {
  testWidgets('FirstPage should navigate to QuotesPage on button press',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<AppSettings>(
        create: (_) => AppSettings(),
        child: MaterialApp(
          home: FirstPage(quotes: const []),
        ),
      ),
    );

    // Tap the first button to navigate to QuotesPage.
    await tester.tap(find.text('😂'));
    await tester.pumpAndSettle();

    // Verify that QuotesPage is displayed.
    expect(find.byType(QuotesPage), findsOneWidget);
  });
}
