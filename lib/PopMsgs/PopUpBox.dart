import 'package:flutter/material.dart';
import 'package:hello_world/PopMsgs/Toast.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';
import 'package:url_launcher/url_launcher.dart';

void calendarPopUpBox(
  BuildContext context, {
  String title = 'test',
  String from = 'test',
  String to = 'test',
  String about = 'test',
  String url = "",
}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
    useSafeArea: true,
    builder: (context) {
      return Center(
        child: SizedBox(
          width: size.width * 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: EnvRes.themeColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      //popup title
                      title: Text(
                        title,
                      ),
                      leading: Icon(Icons.event),
                      subtitle: Column(
                        children: [
                          Divider(
                            color: Colors.transparent,
                          ),
                          //time duration
                          Text('From: ' + from),
                          Text('To     : ' + to),
                          Divider(
                            color: Colors.transparent,
                          ),
                          //event info
                          Container(
                            child: Text(
                              about,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          //url button
                        ],
                      ),
                    ),
                  ),
                  if (url != '')
                    TextButton.icon(
                      onPressed: () {
                        launchURL(url);
                      },
                      icon: Icon(
                        Icons.link,
                      ),
                      label: Text('Join'),
                    )
                  else
                    Divider(
                      color: Colors.transparent,
                    ),
                  //back button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.cyan,
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
    context: context,
  );
}

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    ShowToast("can't open url");
  }
}
