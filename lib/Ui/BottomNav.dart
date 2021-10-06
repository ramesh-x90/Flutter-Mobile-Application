import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 50,
      color: Colors.blueAccent,
      backgroundColor: Colors.white,
      items: <Widget>[
        Icon(Icons.add),
        Icon(Icons.menu),
      ],
    );
  }
}
