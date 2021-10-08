import 'package:flutter/material.dart';
import 'package:hello_world/Models/NewsCardModel.dart';
import 'package:hello_world/Models/TitleWithMoreButton.dart';

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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Icon(Icons.person),
          ),
        ),
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
      body: contain(),
    );
  }

  Widget contain() {
    Size size = MediaQuery.of(context).size;
    TextEditingController DashSearchController = TextEditingController();

    return Column(
      children: [
        //top part of the dash board
        Container(
          height: size.height * 0.2,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.2 - 20,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),

              //Search bar
              Positioned(
                bottom: -0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(1, 2),
                            blurRadius: 20,
                            spreadRadius: 1,
                            color: Colors.black.withAlpha(100)),
                      ]),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 1),
                            child: TextField(
                              controller: DashSearchController,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                            onPressed: () => {print(DashSearchController.text)},
                            icon: Icon(Icons.search)),
                      )
                    ],
                  ),
                ),
              )
              //search bar
            ],
          ),
        ),
        //Events
        loadEvents(),
      ],
    );
  }

  List<String> events = ['demo news 1', 'demo news 2', 'demo news 3'];

  List<bool> iS = [false, false, false];

  //events loading
  //TODO: stream builder
  Widget loadEvents() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          TitleWithMoreButton('News', moreClick),
          Container(
            width: size.width,
            // color: Colors.red,
            child: SingleChildScrollView(
              child: Container(
                width: size.width * .5,
                height: size.height * .4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: eventcardbuilder,
                  itemCount: events.length,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget eventcardbuilder(BuildContext context, int index) {
    String txt = """
              What is Lorem Ipsum?
          Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
          
          Why do we use it?
          It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
          
          
              """;

    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      width: MediaQuery.of(context).size.width * .5,
      child: NewsCardModel(events[index], txt.substring(0, 100), iS[index]),
    );
  }

  moreClick() {
    print('this is more button');
  }
}
