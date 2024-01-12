// test/unit/services/quote_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ElevatE/Services/quote_service.dart';

void main() {
  test('Fetch Motivational Quotes', () async {
    QuoteService quoteService = QuoteService();
    List<String> quotes = await quoteService.fetchMotivationalQuotes('happy', 5);

    expect(quotes, isNotEmpty);
    expect(quotes.length, 5);
  });
}
