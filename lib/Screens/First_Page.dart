import 'package:flutter/material.dart';
import '../Utils/global.dart';
import 'quotes_Page.dart';
import 'liked_quotes_page.dart';
import 'settings_page.dart';
import '../Widgets/app_bar_widget.dart';
import '../Widgets/navbar_widget.dart';

class FirstPage extends StatefulWidget {
  final List<String> quotes;
  FirstPage({required this.quotes});
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double buttonFontSize = 18.0; // Initial value, adjust as needed
  int _currentIndex = 0;
  String searchQuery = '';
  final List<Map<String, String>> emojiMoodMappings = [
    {'😂': 'Happy'},
    {'😇': 'Blessed'},
    {'😔': 'Sad'},
    {'😮‍💨': 'exhausted'},
    {'😫': 'Feel like crying'},
    {'😤': 'pissed off'},
    {'😭': 'crying'},
    {'😰': 'tensed'},
    {'😟': 'Unamused '},
    {'😵‍💫': 'So Confused'},
    {'😑': 'No comments'},
    {'🤯': 'irritated'},
    {'😖': 'embarrassed'},
    {'😬': 'nervoused'},
    {'🥴': 'Dont care'},
    {'🫤': 'confused'},
    {'😝': 'super chilled'},
    {'😡': 'Very Angry'},
    {'🥺': 'emotional'},
    {'😓': 'depressed'},
  ];

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      appBar: appbar(
        searchController: TextEditingController(),
        onSearch: (String query) {
          Future.delayed(Duration.zero, () {
            setState(() {
              searchQuery = query;
            });
          });
        },
        emojiMoodMappings:
            emojiMoodMappings, // Provide the emojiMoodMappings here
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.blue
                    ], // Adjust colors as needed
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(15.0), // Adjust the radius as needed
                    bottomRight:
                        Radius.circular(15.0), // Adjust the radius as needed
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.35,
                child: Center(
                  child: Text(
                    'Hii there,                                         how are you feeling today?',
                    style: TextStyle(
                        fontSize: buttonFontSize + 8,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildButton(context, '😂', 'Happy'),
                        buildButton(context, '😇', 'Blessed'),
                        buildButton(context, '😔', 'very Sad'),
                        buildButton(context, '😫', 'Feel like crying'),
                      ],
                    ),
                    const SizedBox(height: 10), // Adjusted spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildButton(context, '😤', 'pissed off'),
                        buildButton(context, '😭', 'crying'),
                        buildButton(context, '😰', 'tensed'),
                        buildButton(context, '😵‍💫', 'So Confused'),
                      ],
                    ),
                    const SizedBox(height: 10), // Adjusted spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildButton(context, '🤯', 'very irritated'),
                        buildButton(context, '😖', 'embarrassed'),
                        buildButton(context, '🥴', 'Dont care'),
                        buildButton(context, '🫤', 'confused'),
                      ],
                    ),
                    const SizedBox(height: 10), // Adjusted spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildButton(context, '😑', 'No comments'),
                        buildButton(context, '😝', 'Super chilled'),
                        buildButton(context, '😡', 'Very Angry'),
                        buildButton(context, '😬', 'nervoused'),
                      ],
                    ),
                    const SizedBox(height: 10), // Adjusted spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildButton(context, '🥺', 'Very emotional'),
                        buildButton(context, '😮‍💨', 'exhausted'),
                        buildButton(context, '😟', 'Unamused '),
                        buildButton(context, '😓', 'Depressed'),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey, // Set the color of the line
                thickness: 0.5, // Set the thickness of the line
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Quotes for today',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 270, // Set a fixed height or adjust as needed
                      child: ListView.builder(
                        scrollDirection: Axis
                            .horizontal, // Make the list scroll horizontally
                        itemCount: widget.quotes
                            .length, // Replace with the number of cards you want to display
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width *
                                0.5, // Set a fixed width or adjust as needed
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.purple,
                                  Colors.blue
                                ], // Adjust colors as needed
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              // Set your desired background color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                widget.quotes[
                                    index], // Replace with your card content
                                style: const TextStyle(
                                  color: Colors
                                      .white, // Set your desired text color
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FirstPage(
                        quotes: globalQuotes,
                      )),
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

  Widget buildButton(BuildContext context, String emoji, String mood) =>
      OutlinedButton(
        style: OutlinedButton.styleFrom(shape: const CircleBorder()),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => QuotesPage(mood: mood))),
        child: Text(emoji, style: const TextStyle(fontSize: 30)),
      );
}
