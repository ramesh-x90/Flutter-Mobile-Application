import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../BottomNav.dart';
import '../NavDrawer.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('DashBoard'),
        elevation: 20,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.adb),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      bottomNavigationBar: BottomNav(),
    );
  }
}
