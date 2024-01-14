
import 'package:flutter/material.dart';
import 'settings_page.dart';
import '../Utils/global.dart';
import 'first_page.dart';
import '../Widgets/navbar_widget.dart';
import '../widgets/liked_quotes_list.dart';

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
      bottomNavigationBar: CustomBottomNavigationBar(
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



