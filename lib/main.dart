import 'package:flutter/material.dart';
import 'package:hello_world/Ui/homepage.dart';
import 'Ui/Fragments/Chat.dart';
import 'Ui/Loggin.dart';
import 'Ui/Fragments/DashBoard.dart';

// main() {
//   runApp(
//     DevicePreview(
//       builder: (context) => MyApp(),
//     ),
//   );
// }
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //first page of the ui
      initialRoute: '/',
      routes: {
        //route table
        '/brandPage': (context) => WelcomePage(),
        '/logging': (context) => Login(),
        '/DashBoard': (context) => DashBoard(),
        '/chat': (context) => Chat(),
      },
      home: WelcomePage(),
    );
  }
}
