import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class QuoteService {
  Future<List<String>> generateRandomQuotes() async {
    const numberOfQuotes = 6;

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': dotenv.env['APIKEY'] ?? 'API KEY ERROR',
        "model": "gpt-3.5-turbo-0613",
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-instruct',
        'max_tokens': 250,
        "prompt":
        "Generate some good 6 motivational quotes without heading or conclusion and no numbers just display",
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String responseText = data['choices'][0]['text'].toString();
      final List<String> quotesList = responseText.split('\n');
      final List<String> formattedQuotes = quotesList
          .where((quote) => quote.trim().isNotEmpty)
          .map((quote) => quote.trim())
          .toList();

      return formattedQuotes.take(numberOfQuotes).toList();
    } else {
      print('Error: ${response.statusCode}');
      print(response.body);
      return [];
    }
  }

  Future<List<String>> fetchMotivationalQuotes(String mood, int numberOfQuotes) async {


    try {
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/completions"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': dotenv.env['APIKEY'] ?? 'API KEY ERROR',
          "model": "gpt-3.5-turbo-0613",
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo-instruct',
          'max_tokens': 250,
          "prompt":
          "Generate motivational quotes only $numberOfQuotes with  famous author names for $mood mood to uplift my current mood $mood directly display the quotes without any introduction or ending matter",
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String responseText = data['choices'][0]['text'].toString();
        final List<String> quotesList = responseText.split('\n');
        final List<String> formattedQuotes = quotesList
            .where((quote) => quote.trim().isNotEmpty)
            .map((quote) => quote.trim())
            .toList();

        return formattedQuotes;
      } else {
        print('Error: ${response.statusCode}');
        print(response.body);
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }
}