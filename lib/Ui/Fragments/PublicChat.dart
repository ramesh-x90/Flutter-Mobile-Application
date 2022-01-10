import 'package:flutter/material.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/StateSave/CurrentAppstate.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';
import '../NavDrawer.dart';
import '../../Models/ChatWindowModel.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int onlineCount = CurrentAppState.onlineUserCount;

  @override
  void initState() {
    // TODO: implement initState
    Protocol.publicChatListner(callBack);
    super.initState();
  }

  void callBack(int count) {
    if (this.mounted) {
      setState(() {
        onlineCount = count;
      });
    } else {
      onlineCount = count;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: EnvRes.appBarColor,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu)),
        title: ListTile(
          title: Text(
            'Public Chat',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            'Online ${this.onlineCount}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        elevation: 20,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Clear"),
              )
            ],
            onSelected: (value) {
              setState(() {
                //clear chat
                if (value == 1) {
                  // PublicChats.clearchat();
                }
              });
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Chatwindow('PublicChat'),
    );
  }
}
