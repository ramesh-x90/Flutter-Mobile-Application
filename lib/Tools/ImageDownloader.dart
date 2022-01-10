import 'package:flutter/material.dart';

class DownLoadImage extends StatelessWidget {
  String _url;
  DownLoadImage(this._url) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          _url,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.error,
            );
          },
          fit: BoxFit.fitHeight,
          loadingBuilder: (context, child, loadingProgress) {
            return (loadingProgress != null)
                ? Padding(
                    padding: const EdgeInsets.all(30),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : child;
          },
        ),
      ),
    );
  }
}
