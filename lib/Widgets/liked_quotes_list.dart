import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'delete_quote_card.dart';

class LikedQuotesList extends StatefulWidget {
  @override
  _LikedQuotesListState createState() => _LikedQuotesListState();
}

class _LikedQuotesListState extends State<LikedQuotesList> {
  List<String> likedQuotes = [];

  @override
  void initState() {
    super.initState();
    loadLikedQuotes();
  }

  void loadLikedQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? likedQuotesList = prefs.getStringList('liked_quotes');
    if (likedQuotesList != null) {
      setState(() {
        likedQuotes = likedQuotesList;
      });
    }
  }

  void removeLikedQuote(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? likedQuotesList = prefs.getStringList('liked_quotes');
    if (likedQuotesList != null) {
      likedQuotesList.removeAt(index);
      prefs.setStringList('liked_quotes', likedQuotesList);
      loadLikedQuotes(); // Reload the liked quotes
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: likedQuotes.length,
      itemBuilder: (context, index) {
        return QuoteCard(
          quote: likedQuotes[index],
          onDislike: () {
            removeLikedQuote(index);
          },
        );
      },
    );
  }
}
