import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final String _name = "test name";
  final String _iD = "text ID";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.9,

      //drawer

      child: Drawer(
        child: Drawer(
          child: Container(
            color: Colors.white,
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
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.grey.withOpacity(0.9),
                            offset: Offset(0, 0),
                            spreadRadius: 7,
                          ),
                        ]),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 100,
                        ),
                        Column(
                          //header info
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("name : " + _name),
                            Text("ID : " + _iD),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),

                //drawe menu
                ListTile(
                  title: Text('DashBoard'),
                  subtitle: Text("your home"),
                  leading: Icon(Icons.dashboard),
                  selected:
                      ModalRoute.of(context)!.settings.name == '/DashBoard',
                  onTap: () {
                    if (ModalRoute.of(context)!.settings.name != '/DashBoard') {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/DashBoard');
                    } else {
                      Navigator.pop(context);
                    }

                    FocusScope.of(context).unfocus();
                  },
                ),
                ListTile(
                  title: Text('Chat'),
                  subtitle: Text("your Chat"),
                  leading: Icon(Icons.chat),
                  selected: ModalRoute.of(context)!.settings.name == '/chat',
                  onTap: () {
                    if (ModalRoute.of(context)!.settings.name != '/chat') {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/chat');
                    } else {
                      Navigator.pop(context);
                    }

                    FocusScope.of(context).unfocus();
                  },
                ),
                ListTile(
                  title: Text('Calendar'),
                  subtitle: Text("your Calendar"),
                  leading: Icon(Icons.calendar_today),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Settings'),
                  subtitle: Text("your Settings"),
                  leading: Icon(Icons.settings),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  title: Text('Support'),
                  leading: Icon(Icons.support),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Donate'),
                  leading: Icon(Icons.money),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
