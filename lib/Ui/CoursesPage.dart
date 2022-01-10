import 'package:flutter/material.dart';
import 'package:hello_world/Classes/Course.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

import 'Fragments/CoursePage.dart';
import 'NavDrawer.dart';

class CoursesPage extends StatefulWidget {
  CoursesPage() : super();

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  void initState() {
    Protocol.setupCoursePagecallBack(() {
      if (this.mounted) setState(() {});
    });
    if (Courses.getCourses().isEmpty) reqCourseItems();
    super.initState();
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: EnvRes.themeColor,
        title: Text("Courses"),
        elevation: 20,
        leading: IconButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
      ),
      drawer: DrawerWidget(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return (ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: Courses.getCourses().length,
    ));
  }

  Widget itemBuilder(BuildContext context, int index) {
    Course course = Courses.getCourses().elementAt(index);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (Card(
        elevation: 20,
        child: ListTile(
          //course name
          title: Text(
            course.getId() + ' - ' + course.getName(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          //course owner
          subtitle: Text('Module Owner: ' + course.getModuleOwner()),
          //icon
          leading: Container(
            width: 50,
            height: 50,
            //style
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.grey,
                  offset: Offset(0, 3),
                  spreadRadius: 1,
                ),
              ],
              color: Colors.red,
            ),
            child: Icon(
              Icons.book,
              color: Colors.white,
            ),
          ),
          //listtile on click
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoursePageBuilder(course),
                ));
          },
        ),
      )),
    );
  }
}
