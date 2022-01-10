import 'package:flutter/material.dart';
import 'package:hello_world/Classes/Course.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

import 'PdfLoadPage.dart';

class CoursePageBuilder extends StatefulWidget {
  Course course;
  CoursePageBuilder(this.course) : super();

  @override
  _CoursePageBuilderState createState() => _CoursePageBuilderState();
}

class _CoursePageBuilderState extends State<CoursePageBuilder> {
  late Course course;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    course = widget.course;
    Protocol.setCourseResourcesPageCallBack(() {
      if (this.mounted)
        setState(() {
          loading = false;
        });
    });
    reqcourseDocs(course.getId());
    super.initState();
  }

  Widget loadingPro() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EnvRes.themeColor,
        elevation: 20,
        title: Text(
          course.getId() + '-' + course.getName(),
          maxLines: 1,
        ),
      ),
      body: (loading) ? loadingPro() : bodyBuilder(),
    );
  }

  Widget bodyBuilder() => ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //Doc name
                    child: Card(
                      color: EnvRes.themeColor,
                      elevation: 20,
                      child: ListTile(
                        title: Text(
                          course.getCourseDocs().elementAt(index).getTitle(),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //file navigation...course
                  Visibility(
                    visible: course.getCourseDocs()[index].getUrls().isNotEmpty,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          //pdfs
                          ...course
                              .getCourseDocs()
                              .elementAt(index)
                              .getUrls()
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                            offset: Offset(1, 3),
                                          )
                                        ]),
                                    child: ClipRRect(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.book,
                                          color: EnvRes.themeColor,
                                          size: 100,
                                        ),
                                        onPressed: () {
                                          pdfLoadPage(e);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
//info
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ListTile(
                            title: SelectableText(
                              course.getCourseDocs().elementAt(index).getNote(),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
        itemCount: course.getCourseDocs().length,
      );

  void pdfLoadPage(String e) {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfLoadPage(e),
        ),
      );
    } catch (e) {}
  }
}
