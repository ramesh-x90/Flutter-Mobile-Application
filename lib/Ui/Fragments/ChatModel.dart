import 'package:flutter/material.dart';
import 'package:hello_world/NetWorking/Comm.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import '../NavDrawer.dart';

class ChatModel extends StatefulWidget {
  @override
  _ChatModelState createState() => _ChatModelState();
}

class _ChatModelState extends State<ChatModel> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
            onPressed: () {
              // _scaffoldKey.currentState?.openDrawer();
              Navigator.pop(context);
            },
            icon: Icon(Icons.menu)),
        title: Text('demo group'),
        elevation: 20,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("clear chat"),
              )
            ],
            onSelected: (value) {
              setState(() {
                //clear chat
                if (value == 1) {
                  Chats.clearchat();
                }
              });
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Chatwindow(),
    );
  }
}

class Chatwindow extends StatefulWidget {
  @override
  _ChatwindowState createState() => _ChatwindowState();
}

class _ChatwindowState extends State<Chatwindow> {
  final TextEditingController msgbar = TextEditingController();
  final listcontroler = ScrollController();

  void incomingmsglistner() {
    // ignore: await_only_futures
    setState(() {});
    listcontroler.jumpTo(listcontroler.position.maxScrollExtent + 50);
  }

  @override
  void initState() {
    Protocol.setincomingmsglistner(incomingmsglistner);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //all chats goes here
        Expanded(
          child: Container(
            child: ListView.builder(
                controller: listcontroler,
                itemCount: Chats.getchats().length,
                itemBuilder: itemBuilder),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                //space for type messages
                child: Container(
                  margin: EdgeInsets.only(left: 15.0),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(60)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: TextFormField(
                      style: TextStyle(decoration: TextDecoration.none),
                      showCursor: true,
                      controller: msgbar,
                      onFieldSubmitted: sendmsg,
                      textInputAction: TextInputAction.none,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.tag_faces,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () => sendmsg(msgbar.text),
                  icon: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void sendmsg(String msg) {
    setState(() {
      if (msg != '') {
        Chats('me', msg);
        listcontroler.jumpTo(listcontroler.position.maxScrollExtent + 50);
        print(msg);
        Comm.getServer()!.sendmsg(msg);
        msgbar.clear();
      }
    });
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Chats.getchats()[index].getsender() == 'me'
        ? chatchip(index, WrapAlignment.end, Colors.blueGrey.shade200)
        : chatchip(
            index, WrapAlignment.start, Colors.blueAccent.withOpacity(0.65));
  }

//chat buble
  Widget chatchip(int index, WrapAlignment alignment, Color color) {
    return Wrap(
      alignment: alignment,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5.0,
                  offset: Offset(1, 5),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  Chats.getchats()[index].getsender(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  Chats.getchats()[index].getdate(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                // trailing: Icon(Icons.menu),
                onLongPress: () => {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Chats {
  String _sender;
  dynamic _data;
  static List<Chats> _chats = [];

  Chats(
    this._sender,
    this._data,
  ) {
    Chats._chats.add(this);
  }

  String getsender() => this._sender;

  dynamic getdate() => this._data;

  static List<Chats> getchats() => Chats._chats;

  static void clearchat() {
    _chats.clear();
  }
}
