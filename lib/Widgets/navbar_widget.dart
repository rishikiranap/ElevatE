import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
        BottomNavigationBarItem(label: "settings", icon: Icon(Icons.settings)),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
