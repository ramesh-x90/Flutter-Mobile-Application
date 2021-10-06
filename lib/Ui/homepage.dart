import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '/NetWorking/Server.dart';

import 'Loggin.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // ignore: non_constant_identifier_names
  bool _tap_visible = false;
  Server? server;

  @override
  void initState() {
    //initilaze server connection
    this.server = Server(_tap_visibiliy_listner);

    super.initState();
  }

  // ignore: non_constant_identifier_names
  void _tap_visibiliy_listner(bool value) {
    setState(() {
      _tap_visible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'WELCOME',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
          Divider(
            height: 50.0,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.black,
            color: Colors.white,
            minHeight: 1.0,
          ),
          Divider(
            height: 100.0,
          ),
          Visibility(
            visible: this._tap_visible,
            child: TextButton.icon(
                onPressed: () => loadloginscreen(context),
                icon: Icon(
                  Icons.tap_and_play,
                  size: 20,
                ),
                label: Text(
                  "Tap me",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}

void loadloginscreen(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ));
}

const colorizeColors = [
  Colors.white,
  Colors.grey,
  Colors.white,
];

const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  decoration: TextDecoration.none,
  fontFamily: 'Horizon',
);
