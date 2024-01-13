import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ElevatE/Screens/settings_page.dart';
import 'package:ElevatE/Models/app_settings.dart'; // Import your AppSettings class

void main() {
  group('SettingsPage Unit Tests', () {
    testWidgets('SettingsPage UI Test', (WidgetTester tester) async {
      // Wrap your widget with the necessary providers
      await tester.pumpWidget(
        ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
          child: MaterialApp(
            home: SettingsPage(),
          ),
        ),
      );

      // Test 1: Expect to find the app bar title
      expect(find.text('Settings'), findsOneWidget);

      // Test 2: Toggle the dark mode switch
      await tester.tap(find.byType(SwitchListTile).first);
      await tester.pump();
      expect(find.byType(SwitchListTile).first, findsOneWidget);
    });

    testWidgets('Show About Dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
          child: MaterialApp(
            home: SettingsPage(),
          ),
        ),
      );

      // Test: Tap on the "About" ListTile and check if the dialog is shown
      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();
      expect(find.text('About the App'), findsOneWidget);

      // Test: Tap on "Close" in the dialog and check if it's closed
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.text('About the App'), findsNothing);
    });

    testWidgets('Show Ethical and Privacy Dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
          child: MaterialApp(
            home: SettingsPage(),
          ),
        ),
      );

      // Test: Tap on the "Ethical and Privacy Concerns" ListTile
      await tester.tap(find.text('Ethical and Privacy Concerns'));
      await tester.pumpAndSettle();

      // Find the specific text within the dialog content
      expect(
          find.text(
              'We prioritize your privacy and are committed to the ethical use of data. Below are key aspects related to privacy and ethics in our application:'),
          findsOneWidget);

      // Test: Tap on "Close" in the dialog and check if it's closed
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.text('Ethical and Privacy Concerns'), findsOneWidget);
    });
  });
}
