import 'package:flutter/material.dart';
import '../Screens/quotes_page.dart';

class EmojiSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, String>> emojiMoodMappings;
  final Function(String) onSearch;

  EmojiSearchDelegate({
    required this.emojiMoodMappings,
    required this.onSearch,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Update this to show the filtered emojis
    return _buildResultsUI(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display all emojis when the search field is empty
    if (query.isEmpty) {
      return _buildAllButtons(context);
    }

    // You can customize the suggestions UI here if needed
    return Container(
      color: Colors.grey.shade200,
    );
  }

  Widget _buildResultsUI(BuildContext context) {
    // Filter emojis based on the search query
    final List<Map<String, String>> filteredEmojis = query.isEmpty
        ? emojiMoodMappings
        : emojiMoodMappings
            .where((emoji) =>
                emoji.values.first.toLowerCase().contains(query.toLowerCase()))
            .toList();

    // Check if filteredEmojis is empty
    if (filteredEmojis.isEmpty) {
      return Center(
        child: Text(
          'Emoji not found',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      );
    }

    // Display the filtered emojis
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: filteredEmojis.map((emoji) {
        return buildButton(context, emoji);
      }).toList(),
    );
  }

  Widget _buildAllButtons(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: emojiMoodMappings.map((emoji) {
        return buildButton(context, emoji);
      }).toList(),
    );
  }

  Widget buildButtonRow(
      BuildContext context, List<Map<String, String>> emojis) {
    return Center(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: emojis.map((emoji) {
          return Padding(
            padding: const EdgeInsets.all(8.0), // Adjust padding as needed
            child: buildButton(context, emoji),
          );
        }).toList(),
      ),
    );
  }

  Widget buildButton(BuildContext context, Map<String, String> emoji) =>
      OutlinedButton(
        style: OutlinedButton.styleFrom(shape: const CircleBorder()),
        onPressed: () {
          // Extract emoji and mood from the map
          String emojiSymbol = emoji.keys.first;
          String mood = emoji.values.first;

          onSearch(mood);
          close(context, mood);

          // Navigate to QuotesPage with the extracted mood
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuotesPage(mood: mood),
            ),
          );
        },
        child: Text(emoji.keys.first, style: const TextStyle(fontSize: 30)),
      );
}
