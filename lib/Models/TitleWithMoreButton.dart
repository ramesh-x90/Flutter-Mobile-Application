import 'package:flutter/material.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

class TitleWithMoreButton extends StatelessWidget {
  final Function action;
  final String data;
  const TitleWithMoreButton(this.data, this.action);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(1, 5),
                  blurRadius: 10,
                  color: Colors.black.withAlpha(100))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Text(
              this.data,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Spacer(
          flex: 10,
        ),
        TextButton(
          onPressed: () => this.action(),
          style: ButtonStyle(),
          child: Text(
            'more',
            style: TextStyle(color: EnvRes.themeColor),
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
