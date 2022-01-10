import 'package:flutter/material.dart';
import 'package:hello_world/Classes/LatestNews.dart';
import 'package:hello_world/Ui/Fragments/Announcement.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

class NewsCardModel extends StatefulWidget {
  late final String title;
  late final String info;
  late final String imageUrl;

  List<LatestNews> _newslist;
  int index;

  NewsCardModel(this._newslist, this.index) {
    this.title = _newslist[index].eventTitle;
    this.info = _newslist[index].newsBody;
    this.imageUrl = _newslist[index].resURL;
  }

  @override
  _NewsCardModelState createState() => _NewsCardModelState();
}

class _NewsCardModelState extends State<NewsCardModel> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          //news title
          Container(
            padding: EdgeInsets.only(bottom: 5),
            child: ClipRRect(
              child: ListTile(
                tileColor: Colors.blueGrey.shade900,
                title: Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15),
                ),
                // leading: Icon(Icons.announcement),
              ),
            ),
          ),
          //image
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset(2, 5),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  return (loadingProgress != null)
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2.0,
                          ),
                        )
                      : child;
                },
                errorBuilder: (context, error, stackTrace) {
                  // return Icon(Icons.error);
                  return Text(error.toString());
                },
              ),
            ),
          ),
          //body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                (widget.info.length > 200)
                    ? widget.info
                    : widget.info.substring(0, 100) + "...more",
                style: TextStyle(
                  fontSize: 11,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
          ),

          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: widget._newslist[widget.index].favorite
                    ? Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      )
                    : Icon(Icons.favorite_border),
                onPressed: () => {
                  setState(() {
                    if (widget._newslist[widget.index].favorite) {
                      widget._newslist[widget.index].favorite = false;
                    } else {
                      widget._newslist[widget.index].favorite = true;
                    }
                    print(widget._newslist[widget.index].favorite);
                  })
                },
              ),
              //read more button
              TextButton.icon(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullAnnouncementPage(
                          widget.title, widget.info, widget.imageUrl),
                    ),
                  )
                },
                label: Text(
                  'read more',
                  style: TextStyle(color: EnvRes.themeColor),
                ),
                icon: Icon(
                  Icons.read_more,
                  color: EnvRes.themeColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
