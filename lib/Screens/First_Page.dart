import 'package:flutter/material.dart';
import '../Utils/global.dart';
import 'Quotes_Page.dart';
import 'LikedQuotesPage.dart';
import 'Settings_page.dart';



class FirstPage extends StatefulWidget {
  final List<String> quotes;

  FirstPage({required this.quotes});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double buttonFontSize = 18.0; // Initial value, adjust as needed
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/img.png', // Replace with the correct path to your dummy logo
                width: 65,
                height: 65,
              ),
            ),
            const Spacer(),
            const Text(
              'ElevatE',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
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
              height: 280,
              child: Center(
                child: Text(
                  'Hii there,                                    how are you feeling today?',
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
                      buildButton(context, '😁', 'Happy'),
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
                      buildButton(context, '😖', 'irritated'),
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
                      buildButton(context, '🫨', 'Mind Boggling'),
                    ],
                  ),
                  const SizedBox(height: 10), // Adjusted spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildButton(context, '🥺', 'Very emotional'),
                      buildButton(context, '😮‍💨', 'exhausted'),
                      buildButton(context, '😟', 'Shocked'),
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
                      scrollDirection:
                      Axis.horizontal, // Make the list scroll horizontally
                      itemCount: widget.quotes
                          .length, // Replace with the number of cards you want to display
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200, // Set a fixed width or adjust as needed
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                color:
                                Colors.white, // Set your desired text color
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
          BottomNavigationBarItem(
              label: "settings", icon: Icon(Icons.settings)),
        ],
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
            print(globalQuotes);
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
        child: Text(emoji, style: const TextStyle(fontSize: 45)),
      );
}