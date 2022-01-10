import 'package:flutter/material.dart';
import 'package:hello_world/Classes/User.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/StateSave/CurrentAppstate.dart';
import 'package:hello_world/Tools/ImageDownloader.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
    with SingleTickerProviderStateMixin {
  String _name = CurrentAppState.getCurrentUser().getname();
  String _email = CurrentAppState.getCurrentUser().getEmail();
  String _profileImageurl =
      CurrentAppState.getCurrentUser().getProfileImageURL();
  String _role = CurrentAppState.getCurrentUser().getrole();
  late AnimationController ac;

  void setNavDrawerHeader(User user) {
    if (this.mounted) {
      setState(() {
        _name = user.getname();
        _email = user.getEmail();
        _profileImageurl = user.getProfileImageURL();
        _role = user.getrole();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    ac = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    ac.forward();
    reqMyuserInfo();
    CurrentAppState.setNavDrawerCallBack(this.setNavDrawerHeader);
    super.initState();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.9,

      //drawer
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Asset/Images/navDrawer2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // head of drwaer
                  padding: EdgeInsets.all(20),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          EnvRes.themeColor,
                          EnvRes.themeColor,
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.deepPurple,
                        width: 1.5,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey.withOpacity(0.9),
                          offset: Offset(0, 0),
                          spreadRadius: 0.1,
                        ),
                      ]),
                  child: Row(
                    children: [
                      //profile image
                      Container(
                        width: 90,
                        height: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: _profileImageurl == 'null'
                              ? Icon(
                                  Icons.person,
                                  color: Colors.limeAccent,
                                  size: 90,
                                )
                              : DownLoadImage(_profileImageurl),
                        ),
                      ),
                      Divider(
                        color: Colors.red,
                        endIndent: 20,
                      ),
                      Column(
                        //header info
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              //HI
                              Text(
                                "Hi ",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500),
                              ),
                              //username
                              Text(
                                _name.length > 8
                                    ? _name.substring(0, 8)
                                    : _name,
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          //access level
                          Text(
                            _role.toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.amberAccent.shade400),
                          ),
                          Divider(
                            height: 2,
                          ),
                          //email
                          Text(
                            _email,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),

              //drawe menu
              AnimatedBuilder(
                  animation: ac,
                  builder: (context, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(0.0, 0.2), end: Offset.zero)
                          .animate(ac),
                      child: child,
                    );
                  },
                  child: DrawerMenuItem('/DashBoard', Icons.dashboard)),
              AnimatedBuilder(
                animation: ac,
                builder: (context, child) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(0.0, 0.3), end: Offset.zero)
                            .animate(ac),
                    child: child,
                  );
                },
                child: DrawerMenuItem('/chat', Icons.chat),
              ),
              AnimatedBuilder(
                animation: ac,
                builder: (context, child) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(0.0, 0.1), end: Offset.zero)
                            .animate(ac),
                    child: child,
                  );
                },
                child: DrawerMenuItem('/Courses', Icons.cast_for_education),
              ),
              AnimatedBuilder(
                animation: ac,
                builder: (context, child) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(0.0, 0.4), end: Offset.zero)
                            .animate(ac),
                    child: child,
                  );
                },
                child: DrawerMenuItem('/Calendar', Icons.calendar_today),
              ),
              AnimatedBuilder(
                animation: ac,
                builder: (context, child) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(0.0, 0.3), end: Offset.zero)
                            .animate(ac),
                    child: child,
                  );
                },
                child: DrawerMenuItem('/Settings', Icons.settings),
              ),

              Divider(),

              // DrawerMenuItem('/Support', Icons.support,
              //     backColor: Color(0xffd41900).withAlpha(150)),
              // DrawerMenuItem('/Donate', Icons.money,
              //     backColor: Color(0xffd41900).withAlpha(150)),

              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  //logout butn
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "Do you want to log out?",
                            style: TextStyle(fontSize: 12),
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                CurrentAppState.removeSP('username');
                                CurrentAppState.removeSP('password');
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/logging', (route) => false);
                              },
                              child: Text('Yes'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                              style: ElevatedButton.styleFrom(
                                primary: EnvRes.themeColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(Icons.logout),
                    style: ElevatedButton.styleFrom(
                      primary: EnvRes.themeColor,
                    ),
                  ),

                  //share btn
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.share),
                    style: ElevatedButton.styleFrom(
                      primary: EnvRes.themeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DrawerMenuItem extends StatelessWidget {
  bool isSelected = false;
  Color selectedcolor = Colors.deepPurple;
  Color notSelectedcolor = Colors.grey.shade800;
  var background;
  final String route;
  IconData tileicon;
  DrawerMenuItem(this.route, this.tileicon, {Color? backColor}) {
    this.background = (backColor != null) ? backColor : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    isSelected = ModalRoute.of(context)!.settings.name == route;
    return (Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
          color: background,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black,
          //     blurRadius: 10,
          //     offset: Offset(1, 3),
          //     spreadRadius: 0.1,
          //   )
          // ],
        ),
        child: ListTile(
          title: Text(
            route.substring(1, 2).toUpperCase() +
                route.substring(2).toLowerCase(),
            style: TextStyle(
              color: (isSelected) ? selectedcolor : notSelectedcolor,
            ),
          ),
          leading: Icon(
            this.tileicon,
            color: (isSelected) ? selectedcolor : notSelectedcolor,
          ),
          selected: isSelected,
          onTap: () {
            if (ModalRoute.of(context)!.settings.name != route) {
              //
              if (ModalRoute.of(context)!.settings.name == '/DashBoard') {
                Navigator.pushNamedAndRemoveUntil(
                    context, route, (route) => false);
              } else {
                Navigator.pushNamed(context, route);
              }
            } else {
              Navigator.pop(context);
            }

            // FocusScope.of(context).unfocus();
          },
          selectedTileColor: Colors.white,
        ),
      ),
    ));
  }
}
