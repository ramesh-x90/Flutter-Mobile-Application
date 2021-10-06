import 'package:hello_world/Ui/Fragments/Chat.dart';

class Protocol {
  /*
  protocol for communication
  
   */

  // ignore: non_constant_identifier_names
  static Function? LoginVerficationlistner;
  static Function? incomingmsglistner;

  static void listner(String response) {
    String s = '*@*!';
    //msgs related to login
    if (response.contains('logging=')) {
      if (response.contains('verified')) {
        if (LoginVerficationlistner != null) {
          LoginVerficationlistner!(1);
        }
      }
    }
    if (response.substring(0, 5).contains('fmsg=')) {
      if (incomingmsglistner != null) {
        //update chat ui
        incomingmsglistner!();
      }

      List<dynamic> _rowdata = [];
      _rowdata = response.split(s);
      int _senderindex = _rowdata[1].lastIndexOf('=') + 1;
      String _sender = _rowdata[1].substring(_senderindex);

      int _dataindex = _rowdata[2].lastIndexOf('=') + 1;
      dynamic _data = _rowdata[2].substring(_dataindex);

      // ignore: unused_local_variable
      final Chats amsg = Chats(
        _sender,
        _data,
      );
    }
  }

  //login page listner for open menu
  static void setloginpagelistner(Function fn) {
    LoginVerficationlistner = fn;
  }

  static void setincomingmsglistner(Function fn) {
    incomingmsglistner = fn;
  }
}
