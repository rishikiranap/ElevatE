import 'package:flutter/material.dart';
import 'emoji_search.dart'; // Make sure to import EmojiSearchDelegate

class appbar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final List<Map<String, String>> emojiMoodMappings;

  appbar({
    required this.searchController,
    required this.onSearch,
    required this.emojiMoodMappings,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/img.png',
              width: 65,
              height: 65,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: const Text(
                'ElevatE',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: EmojiSearchDelegate(
                    emojiMoodMappings: emojiMoodMappings,
                    onSearch: onSearch,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
