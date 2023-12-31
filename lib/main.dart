import 'package:flutter/material.dart';
import 'package:ElevatE/Settings_page.dart';
import 'package:ElevatE/LikedQuotesPage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';
import 'app_settings.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSettings(),
      child: const MyApp(),
    ),
  );
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img.png', // Replace with the correct path to your logo
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeApp().then((_) async {
      List<String> cachedQuotes = await loadQuotes();
      if (cachedQuotes.isEmpty) {
        List<String> generatedQuotes = await generateRandomQuotes();
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

  Future<List<String>> generateRandomQuotes() async {
    const numberOfQuotes = 6;

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
        "model": "gpt-3.5-turbo-0613",
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-instruct',
        'max_tokens': 250,
        "prompt":
            "Generate some good 6 motivational quotes wihtout heading or conclusion and no numbers just display",
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String responseText = data['choices'][0]['text'].toString();
      final List<String> quotesList = responseText.split('\n');
      final List<String> formattedQuotes = quotesList
          .where((quote) => quote.trim().isNotEmpty)
          .map((quote) => quote.trim())
          .toList();

      return formattedQuotes.take(numberOfQuotes).toList();
    } else {
      print('Error: ${response.statusCode}');
      print(response.body);
      return [];
    }
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
            Spacer(),
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
                  SizedBox(height: 10), // Adjusted spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildButton(context, '😤', 'pissed off'),
                      buildButton(context, '😭', 'crying'),
                      buildButton(context, '😰', 'tensed'),
                      buildButton(context, '😵‍💫', 'So Confused'),
                    ],
                  ),
                  SizedBox(height: 10), // Adjusted spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildButton(context, '🤯', 'very irritated'),
                      buildButton(context, '😖', 'irritated'),
                      buildButton(context, '🥴', 'Dont care'),
                      buildButton(context, '🫤', 'confused'),
                    ],
                  ),
                  SizedBox(height: 10), // Adjusted spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildButton(context, '😑', 'No comments'),
                      buildButton(context, '😝', 'Super chilled'),
                      buildButton(context, '😡', 'Very Angry'),
                      buildButton(context, '🫨', 'Mind Boggling'),
                    ],
                  ),
                  SizedBox(height: 10), // Adjusted spacing
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
                    padding: const EdgeInsets.all(8.0),
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

class QuotesPage extends StatefulWidget {
  final String mood;
  const QuotesPage({Key? key, required this.mood}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  bool _isLoading = true;

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
              padding: const EdgeInsets.all(8.0),
              child: Text('Motivational Quotes'),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: _quotes
                      .map(
                        (quote) => QuoteCard(quote: quote),
                      )
                      .toList(),
                ),
              ),
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
                  builder: (context) => FirstPage(quotes: _quotes)),
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

  Future<void> fetchMotivationalQuotes() async {
    var appSettings = Provider.of<AppSettings>(context, listen: false);
    try {
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/completions"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer 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',
          "model": "gpt-3.5-turbo-0613",
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo-instruct',
          'max_tokens': 250,
          "prompt":
              "Generate motivational quotes only ${appSettings.numberOfQuotes} with  famous author names for ${widget.mood} mood to uplift my current mood ${widget.mood} directly display the quotes without any introduction or ending matter",
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String responseText = data['choices'][0]['text'].toString();
        final List<String> quotesList = responseText.split('\n');
        final List<String> fomrattedquo = quotesList
            .where((quote) => quote.trim().isNotEmpty)
            .map((quote) => quote.trim())
            .toList();
        print(fomrattedquo);
        setState(() {
          _quotes = fomrattedquo;
          _isLoading = false;
        });
      } else {
        print('Error: ${response.statusCode}');
        print(response.body);
        // Handle error and set _isLoading to false
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Exception: $e');
      // Handle exception and set _isLoading to false
      setState(() {
        _isLoading = false;
      });
    }
  }
}

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
            SizedBox(height: 1.0), // Add space between quote and like button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: _isLiked
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
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
