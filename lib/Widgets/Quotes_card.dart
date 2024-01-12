import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class QuoteCard extends StatefulWidget {
  final String quote;

  const QuoteCard({Key? key, required this.quote}) : super(key: key);

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    // Load liked status from local storage
    loadLikedStatus();
  }

  // Load liked status from local storage
  void loadLikedStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLiked = prefs.getBool(widget.quote) ?? false;
    });
  }

  // Save liked status to local storage
  void saveLikedStatus(bool liked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.quote, liked);

    if (liked) {
      // Save the liked quote to the list in SharedPreferences
      List<String> likedQuotesList = prefs.getStringList('liked_quotes') ?? [];
      likedQuotesList.add(widget.quote);
      prefs.setStringList('liked_quotes', likedQuotesList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      color: Colors.white70,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.quote,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(
                height: 1.0), // Add space between quote and like button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: _isLiked
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                    // Save liked status to local storage
                    saveLikedStatus(_isLiked);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}