import 'package:flutter/material.dart';
import 'first_page.dart';
import 'liked_quotes_page.dart' as LikedPage;
import 'settings_page.dart';
import '../Services/quote_service.dart';
import '../Widgets/quotes_card.dart';
import '../Models/app_settings.dart';
import 'package:provider/provider.dart';
import '../Widgets/navbar_widget.dart';

class QuotesPage extends StatefulWidget {
  final String mood;

  const QuotesPage({Key? key, required this.mood}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  bool _isLoading = true;
  int _currentIndex = 0;
  List<String> _quotes = [];

  @override
  Widget build(BuildContext context) {
    var appSettings = Provider.of<AppSettings>(context);
    // Fetch quotes only when the widget is being built
    if (_isLoading) {
      fetchMotivationalQuotes();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Motivational Quotes'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img.png',
                // Replace with the correct path to your dummy logo
                width: 65,
                height: 65,
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: buildQuotesList(), // Use the buildQuotesList method
            ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,

        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FirstPage(quotes: _quotes),
              ),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LikedPage.LikedQuotesPage()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
      ),
    );
  }

  // Helper method to build the list of QuoteCard widgets
  Widget buildQuotesList() {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children:
            _quotes.map<Widget>((quote) => QuoteCard(quote: quote)).toList(),
      ),
    );
  }

  Future<void> fetchMotivationalQuotes() async {
    QuoteService quoteService = QuoteService();
    AppSettings appSettings = Provider.of<AppSettings>(context, listen: false);

    try {
      List<String> quotes = await quoteService.fetchMotivationalQuotes(
          widget.mood, appSettings.numberOfQuotes);
      setState(() {
        _quotes = quotes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching quotes: $e');
      // Handle the error appropriately
    }
  }
}
