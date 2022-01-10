import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello_world/Classes/LatestNews.dart';
import 'package:hello_world/Models/NewsCardModel.dart';
import 'package:hello_world/Models/TitleWithMoreButton.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';
import '../BottomNav.dart';
import '../NavDrawer.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ScrollController _sc = ScrollController();
  ScrollController eventlistController = ScrollController();
  double headerH = 0;
  late AnimationController ac;

  bool headercollaps = false;
  bool autoScroll = true;

  void refresh() {
    if (this.mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    headerH = window.physicalSize.height * 0.13;
    ac = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    ac.forward();

    Protocol.setDashBoardRefreshCallBack(refresh);
    reqLatestNews();
    _sc.addListener(() {
      if (_sc.position.pixels > 0 && !headercollaps) {
        setState(() {
          headerH = 75;
          headercollaps = true;
        });
      } else if (_sc.position.pixels == 0 && headercollaps) {
        setState(() {
          headerH = window.physicalSize.height * 0.13;
          headercollaps = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _sc.dispose();
    ac.dispose();
    eventlistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ),
        backgroundColor: EnvRes.dashboardHeadColor,
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
      // bottomNavigationBar: BottomNav(),
      body: contain(),
    );
  }

  Widget contain() {
    Size size = MediaQuery.of(context).size;
    TextEditingController dashSearchController = TextEditingController();

    return Column(
      children: [
        //top part of the dash board
        AnimatedContainer(
          // height: size.height * 0.2,
          height: headerH,
          duration: Duration(milliseconds: 1500),
          curve: Curves.easeInOut,

          child: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeInOut,
                width: size.width,
                height: headerH - 25,
                decoration: BoxDecoration(
                  color: EnvRes.appBarColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),

              //Search bar
              Positioned(
                bottom: 0,
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
                              controller: dashSearchController,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onSubmitted: (value) {
                                filter(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                            onPressed: () {
                              filter(dashSearchController.text);
                            },
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
        Divider(
          color: Colors.transparent,
          height: 15,
        ),
        //Events
        loadEvents(),
      ],
    );
  }

  void filter(String value) {
    print(value);

    if (value == '') {
      setState(() {
        LatestNews.setFilter('');
      });
      return;
    }

    setState(() {
      LatestNews.setFilter(value);
    });
  }

  //events loading
  //TODO: stream builder
  Widget loadEvents() {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        child: RefreshIndicator(
      onRefresh: pullrefresh,
      child: ListView(
        controller: _sc,
        children: [
          TitleWithMoreButton('Announcements', moreClick),
          SingleChildScrollView(
            child: AnimatedBuilder(
              animation: ac,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                          begin: Offset(0.8, 0.0), end: Offset.zero)
                      .animate(
                          CurvedAnimation(parent: ac, curve: Curves.easeInOut)),
                  child: child,
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: ac.value),
                height: 500,
                child: ListView.builder(
                  cacheExtent: 100,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: eventcardbuilder,
                  itemCount: LatestNews.getfiltedEvents().length,
                ),
              ),
            ),
          ),
          TitleWithMoreButton('field2', moreClick),
          SingleChildScrollView(
            child: AnimatedBuilder(
              animation: ac,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                          begin: Offset(0.8, 0.0), end: Offset.zero)
                      .animate(
                          CurvedAnimation(parent: ac, curve: Curves.easeInOut)),
                  child: child,
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: ac.value),
                height: 500,
                child: ListView.builder(
                  cacheExtent: 100,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: eventcardbuilder,
                  itemCount: LatestNews.getfiltedEvents().length,
                ),
              ),
            ),
          ),
          // TitleWithMoreButton('field3', moreClick),
          // TitleWithMoreButton('field4', moreClick),
        ],
      ),
    ));
  }

  Widget eventcardbuilder(BuildContext context, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .5,
      child: NewsCardModel(LatestNews.getfiltedEvents(), index),
    );
  }

  moreClick() {
    print('this is more button');
  }

  Future<void> pullrefresh() async {
    setState(() {
      reqLatestNews();
    });
  }

  void enddrag(DragEndDetails details) {
    autoScroll = false;
  }

  void ondrag(DragStartDetails details) {
    autoScroll = true;
  }

  void updateDrag(DragUpdateDetails details) {
    autoScroll = false;
  }
}
