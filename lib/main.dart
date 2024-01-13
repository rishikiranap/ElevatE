import 'package:ElevatE/Services/quote_service.dart';
import 'package:ElevatE/Screens/first_page.dart';
import 'package:ElevatE/Screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/app_settings.dart';
import 'Utils/global.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSettings(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInitialized = false;
  final QuoteService quoteService = QuoteService();

  @override
  void initState() {
    super.initState();
    initializeApp().then((_) async {
      List<String> cachedQuotes = await loadQuotes();
      if (cachedQuotes.isEmpty) {
        List<String> generatedQuotes =
            await quoteService.generateRandomQuotes();
        saveQuotes(generatedQuotes);
        setState(() {
          globalQuotes = generatedQuotes;
          isInitialized = true;
        });
      } else {
        setState(() {
          globalQuotes = cachedQuotes;
          isInitialized = true;
        });
      }
    });
  }

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 6));
  }

  Future<List<String>> loadQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? quotes = prefs.getStringList('quotes');
    return quotes ?? [];
  }

  Future<void> saveQuotes(List<String> quotes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cached_quotes', quotes);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElevatE',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<AppSettings>(context).themeData,
      home: isInitialized ? FirstPage(quotes: globalQuotes) : LoadingScreen(),
    );
  }
}
