import 'package:flutter/material.dart';
import 'First_Page.dart';
import 'LikedQuotesPage.dart' as LikedPage;
import 'Settings_page.dart';
import '../Services/quote_service.dart';
import '../Widgets/Quotes_card.dart';

class QuotesPage extends StatefulWidget {
  final String mood;
  const QuotesPage({Key? key, required this.mood}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  bool _isLoading = true;
  int _numberOfQuotes = 5;
  List<String> _quotes = [];

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
          BottomNavigationBarItem(
              label: "settings", icon: Icon(Icons.settings)),
        ],
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
              MaterialPageRoute(builder: (context) => LikedPage.LikedQuotesPage()),
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
        children: _quotes
            .map<Widget>((quote) => QuoteCard(quote: quote))
            .toList(),
      ),
    );
  }

  Future<void> fetchMotivationalQuotes() async {
    QuoteService quoteService = QuoteService();

    try {
      List<String> quotes = await quoteService.fetchMotivationalQuotes(
          widget.mood, _numberOfQuotes);
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