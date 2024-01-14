import 'package:flutter/material.dart';

class appbar extends StatelessWidget implements PreferredSizeWidget {
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search button pressed
              },
            ),
          ),
        ],
      ),
    );
  }
}