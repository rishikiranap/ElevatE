import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'Settings_page.dart';
import 'global.dart';

class LikedQuotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Saved Quotes'),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img.png', // Replace with the correct path to your dummy logo
                width: 65,
                height: 65,
              ),
            ),
          ],
        ),
      ),
      body: LikedQuotesList(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
          BottomNavigationBarItem(label: "settings", icon: Icon(Icons.settings)),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstPage(quotes: globalQuotes )),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LikedQuotesPage()),
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
}

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

class QuoteCard extends StatelessWidget {
  final String quote;
  final VoidCallback onDislike;

  QuoteCard({required this.quote, required this.onDislike});

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
              quote,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: onDislike,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
