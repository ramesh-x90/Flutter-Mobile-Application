import 'package:flutter/material.dart';
import 'package:hello_world/PopMsgs/Toast.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfLoadPage extends StatefulWidget {
  String uri;

  PdfLoadPage(this.uri) : super();

  @override
  _PdfLoadPageState createState() => _PdfLoadPageState();
}

class _PdfLoadPageState extends State<PdfLoadPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDFViwer'),
        backgroundColor: EnvRes.themeColor,
      ),
      body: SfPdfViewer.network(
        widget.uri,
        key: _pdfViewerKey,
        onDocumentLoadFailed: (details) {
          ShowToast('Error!!');
          Navigator.pop(context);
        },
      ),
    );
  }
}
