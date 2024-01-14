import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ElevatE/Models/app_settings.dart'; // Replace with the actual path
import 'package:ElevatE/Screens/Quotes_Page.dart'; // Replace with the actual path

void main() {
  testWidgets('QuotesPage shows loading indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
          child: Builder(
            builder: (context) {
              return const QuotesPage(mood: 'Happy');
            },
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('QuotesPage shows loading indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
          child: Builder(
            builder: (context) {
              return const QuotesPage(mood: 'Irritated');
            },
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('QuotesPage navigation', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AppSettings>(
          create: (_) => AppSettings(),
          child: Builder(
            builder: (context) {
              return const QuotesPage(mood: 'Happy');
            },
          ),
        ),
      ),
    );
  });
}
