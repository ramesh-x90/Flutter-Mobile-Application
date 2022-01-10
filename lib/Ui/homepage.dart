import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/StateSave/CurrentAppstate.dart';
import '/NetWorking/Server.dart';

import 'Loggin.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  bool _tap_visible = false;
  Server? server;
  late AnimationController ac;
  late Animation scaleAnimation;

  @override
  void initState() {
    //initilaze server connection
    ac = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    scaleAnimation = Tween(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: ac, curve: Curves.easeInOut),
    );
    ac.repeat(
      reverse: true,
    );
    Server.init(_tap_visibiliy_listner);
    CurrentAppState.initSharedPreferences();

    super.initState();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  void _tap_visibiliy_listner(bool value) {
    if (this.mounted) {
      setState(() {
        _tap_visible = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Color(0xff12516c),
        image: DecorationImage(
          image: AssetImage("Asset/Images/background2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(
            flex: 5,
          ),
          AnimatedBuilder(
            animation: ac,
            builder: (context, child) {
              return Transform.scale(
                scale: scaleAnimation.value,
                child: child,
              );
            },
            child: Image(
              height: 150,
              image: AssetImage(
                "Asset/Images/logo4.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          // AnimatedTextKit(
          //   animatedTexts: [
          //     ColorizeAnimatedText(
          //       'LIGHT RAIN',
          //       speed: const Duration(milliseconds: 1000),
          //       textStyle: colorizeTextStyle,
          //       colors: colorizeColors,
          //     ),
          //   ],
          //   isRepeatingAnimation: true,
          //   repeatForever: true,
          // ),
          Divider(
            color: Colors.transparent,
          ),
          RichText(
            text: TextSpan(
              text: "LIGHT ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontSize: 20,
              ),
              children: const <TextSpan>[
                TextSpan(
                    text: 'RAIN',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    )),
              ],
            ),
          ),
          Spacer(
            flex: 10,
          ),
          Visibility(
            visible: !this._tap_visible,
            child: Column(
              children: [
                CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Text(
                  "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: this._tap_visible,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Color(0xff19599A),
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              child: TextButton(
                  onPressed: () => loadloginscreen(context),
                  child: Text(
                    "Start",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Divider(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.transparent,
          ),
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

// const colorizeColors = [
//   Colors.white30,
//   Colors.grey,
//   Colors.white30,
//   Colors.grey,
//   Colors.white30,
//   Colors.grey,
//   Colors.white30,
// ];

// const colorizeTextStyle = TextStyle(
//   fontSize: 25.0,
//   decoration: TextDecoration.none,
//   fontFamily: 'Horizon',
// );
