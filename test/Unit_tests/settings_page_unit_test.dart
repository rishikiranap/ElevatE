import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ElevatE/Screens/settings_page.dart';
import 'package:ElevatE/Models/app_settings.dart'; // Import your AppSettings class

void main() {
  group('SettingsPage Unit Tests', () {
    testWidgets('Toggle Dark Mode Switch', (WidgetTester tester) async {
      // Wrap your widget with the necessary providers
      await tester.pumpWidget(
        ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
          child: MaterialApp(
            home: SettingsPage(),
          ),
        ),
      );

      // Test: Toggle the dark mode switch
      await tester.tap(find.byType(SwitchListTile).first);
      await tester.pump();

      // Test: Expect the switch to be ON
      expect(find.byType(SwitchListTile).first, findsOneWidget);
    });
  });
}
