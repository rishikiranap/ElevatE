
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart';
import '../Utils/global.dart';
import 'first_page.dart';

class LikedQuotesPage extends StatefulWidget {
  @override
  _LikedQuotesPageState createState() => _LikedQuotesPageState();
}

class _LikedQuotesPageState extends State<LikedQuotesPage> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Liked Quotes'),
            ),
            const Spacer(),
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
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstPage(quotes: globalQuotes, )),
            );
          }
          if (index == 1) {
            // No need to navigate to LikedQuotesPage since we are already on it
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

  const QuoteCard({required this.quote, required this.onDislike});

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this quote?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onDislike(); // Trigger the delete action
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
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
              quote,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context);
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
