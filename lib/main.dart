import 'package:flutter/material.dart';
import 'package:hello_world/Ui/CoursesPage.dart';
import 'package:hello_world/Ui/Donate.dart';
import 'package:hello_world/Ui/Setting.dart';
import 'package:hello_world/Ui/homepage.dart';
import 'Support.dart';
import 'Ui/Calendar.dart';
import 'Ui/Fragments/PublicChat.dart';
import 'Ui/Loggin.dart';
import 'Ui/Fragments/DashBoard.dart';
import 'Ui/Registration.dart';

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
        '/RegistrationForm': (context) => RegistrationForm(),
        '/DashBoard': (context) => DashBoard(),
        '/Calendar': (context) => Calendar(),
        '/Settings': (context) => Settings(),
        '/Support': (context) => Support(),
        '/Donate': (context) => Donate(),
        '/chat': (context) => Chat(),
        '/Courses': (context) => CoursesPage(),
      },
      home: WelcomePage(),
      // home: Calendar(),
      // home: Chat(),
    );
  }
}
