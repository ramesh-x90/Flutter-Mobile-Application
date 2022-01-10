import 'package:flutter/material.dart';
import 'package:hello_world/Classes/Chat.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/StateSave/CurrentAppstate.dart';
import 'package:hello_world/Tools/ImageDownloader.dart';
import 'package:hello_world/res/customicons_icons.dart';

class Chatwindow extends StatefulWidget {
  String _dest;
  Chatwindow(this._dest);

  @override
  _ChatwindowState createState() => _ChatwindowState();
}

class _ChatwindowState extends State<Chatwindow> {
  final TextEditingController msgbar = TextEditingController();
  final listcontroler = ScrollController();
  List<Chat> list = [];

  void incomingmsglistner() {
    // ignore: await_only_futures
    setState(() {});
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
    list = Chat.getchats()
        .where((element) => element.getdestination() == widget._dest)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //all chats goes here
        Expanded(
          child: Container(
            child: ListView.builder(
                reverse: true,
                controller: listcontroler,
                itemCount: list.length,
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
              //send button
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
        Chat chat = Chat(CurrentAppState.getCurrentUser(), msg, widget._dest,
            DateTime.now().toString());
        print(msg);

        //send msg to server
        sendMsg(chat);
        msgbar.clear();
      }
    });
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Chat.getchats()[index].getsender().getname() ==
            CurrentAppState.getCurrentUser().getname()
        ? chatchip(index, WrapAlignment.end, Colors.blueGrey.shade700)
        : chatchip(index, WrapAlignment.start, Colors.teal.shade900);
  }

//chat buble
  Widget chatchip(int index, WrapAlignment alignment, Color color) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double len = scrnwidth * 0.4 * (list[index].getdata().length * 0.05 + 1);
    return Wrap(
      alignment: alignment,
      children: [
        Padding(
          //box
          padding: const EdgeInsets.all(10),
          child: Container(
            width: (len < scrnwidth) ? len : scrnwidth * 0.7,
            //styling
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
            child: Padding(
              padding: const EdgeInsets.all(1),
              //list tile
              child: ListTile(
                leading: list[index].getsender().getProfileImageURL() != "null"
                    ? Container(
                        width: 30,
                        height: 30,
                        child: DownLoadImage(
                            list[index].getsender().getProfileImageURL()),
                      )
                    : Icon(Icons.person),
                //senders name
                title: Text(
                  list[index].getsender().getname(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.w400),
                ),

                // msg
                subtitle: Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    list[index].getdata(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                trailing: (list[index].getsender().isAdmin()
                    ? Icon(
                        Icons.admin_panel_settings,
                        color: Colors.red,
                      )
                    : list[index].getsender().isLecturer()
                        ? Icon(
                            Customicons.lecturer,
                            color: Colors.white,
                          )
                        : Icon(
                            Customicons.student,
                            color: Colors.white,
                          )),
                onLongPress: () => {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
