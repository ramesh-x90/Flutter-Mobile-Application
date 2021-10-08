import 'package:flutter/material.dart';
import '../NavDrawer.dart';
import 'ChatModel.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List groups = ["Group1", "Group2", "Group3", "Group4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu)),
        title: Text('Chat'),
        elevation: 20,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("refresh"),
              )
            ],
            onSelected: (value) {
              setState(() {
                //clear chat
                if (value == 1) {}
              });
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: buildGroupList(),
    );
  }

  Widget buildGroupList() {
    return ListView.builder(
        itemBuilder: groupitembuilder, itemCount: groups.length);
  }

  Widget groupitembuilder(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        //list tile for group chats
        child: Card(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            // tileColor: Colors.amber,
            title: Text(
              groups[index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("group name"),
            //container for the group image
            //TODO: stream builder
            leading: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 20,
                    offset: Offset(1, 2),
                    spreadRadius: 1,
                    color: Colors.black.withAlpha(100),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(
                  Icons.group,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
            trailing: Icon(Icons.menu),
            onLongPress: () => {print('hellow')},
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatModel()))
            },
          ),
        ),
      ),
    );
  }
}
