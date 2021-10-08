import 'package:flutter/material.dart';

class NewsCardModel extends StatefulWidget {
  String title = 'no title';
  String info = 'test data';
  bool isSelected = false;

  NewsCardModel(this.title, this.info, this.isSelected);

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
          ListTile(
            title: Text(widget.title),
            leading: Icon(Icons.arrow_drop_down_circle),
          ),
          Icon(
            Icons.find_in_page,
            size: 100,
            color: Colors.grey,
          ),
          Expanded(child: Text(widget.info)),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: widget.isSelected
                    ? Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      )
                    : Icon(Icons.favorite_border),
                onPressed: () => {
                  setState(() {
                    if (widget.isSelected) {
                      widget.isSelected = false;
                    } else {
                      widget.isSelected = true;
                    }
                    print(widget.isSelected);
                  })
                },
              ),
              TextButton.icon(
                onPressed: () => {},
                label: Text('read more'),
                icon: Icon(Icons.read_more),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
