import 'package:flutter/material.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

class FullAnnouncementPage extends StatelessWidget {
  String title;
  String info;
  String imageUrl;

  FullAnnouncementPage(this.title, this.info, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: EnvRes.appBarColor,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 1,
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        this.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 1,
                                color: Colors.grey,
                                offset: Offset(0, 2),
                                spreadRadius: 2,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              this.imageUrl,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Text(
                            this.info,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: EnvRes.themeColor,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
