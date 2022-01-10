import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 50,
      color: EnvRes.bottomNavColor,
      backgroundColor: Colors.white,
      items: <Widget>[
        Icon(
          Icons.account_balance,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          color: Colors.white,
        ),
      ],
    );
  }
}
