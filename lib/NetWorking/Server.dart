import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:hello_world/PopMsgs/Toast.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/StateSave/CurrentAppstate.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

import 'Comm.dart';

class Server {
  static String _host = EnvRes.serverAddress;
  static int _port = EnvRes.serverPort;
  static Socket? socket;
  String serverResponse = "null";
  // ignore: non_constant_identifier_names
  static late Function set_tap_visibiliy;
  static String buffer = '';
  static bool recon = false;

  static void init(Function function) {
    set_tap_visibiliy = function;
    _connect();
  }

  //make connection to the server
  static Future<void> _connect() async {
    Socket _socket;
    while (socket == null) {
      try {
        _socket = await Socket.connect(
          _host,
          _port,
          timeout: Duration(seconds: 10),
        );

        _socket.listen(
          getServerResponse,
          onError: (error) {
            print("Onerror=" + error);
            _socket.destroy();
            socket?.destroy();
          },
          onDone: () {
            print('server left');
            ShowToast("Connection lost");
            set_tap_visibiliy(false);
            _socket.destroy();
            socket?.destroy();
            buffer = '';
            socket = null;
            recon = true;
            Server.init(set_tap_visibiliy);
          },
        );

        //make available to enter to application
        set_tap_visibiliy(true);
        socket = _socket;
        await send(msg: "protocol version=${Protocol.version}");
        if (recon) checkCredentialsinShared();
        break;
      } catch (e) {
        print('RRROR::::::');
        print(e.toString());
      }
    }
  }

  static void checkCredentialsinShared() async {
    var spname = await CurrentAppState.getPreferencesStringvalue('username');
    var sppass = await CurrentAppState.getPreferencesStringvalue('password');

    if (spname != null && sppass != null) reqLoging(spname, sppass);
  }

  //sending data to server
  static Future<void> send(
      {String msg = 'hello server', var binaryData}) async {
    socket != null ? log('client:$msg') : print('socket is null');

    if (binaryData == null) {
      socket?.add(utf8.encode(msg) + utf8.encode('[<->END<->]'));
    } else {
      socket?.add(utf8.encode(msg) +
          utf8.encode('[<->BINARYDATA<->:]') +
          binaryData +
          utf8.encode('[<->END<->]'));
      log('file:$binaryData');
    }
  }

  //callback function when new data arrived
  static Future<void> getServerResponse(data) async {
    String serverResponse = await _decode(data);

    callProtcol(serverResponse);

    // Protocol.listner(serverResponse);
  }

  static void callProtcol(String serverRes) {
    buffer += serverRes;

    if (!buffer.contains('[<->END<->]')) return;

    String oneRes = '';
    List<String> sp = [];
    sp = buffer.split(
      '[<->END<->]',
    );

    if (buffer.endsWith('[<->END<->]')) {
      for (String a in sp) {
        if (a.isNotEmpty) {
          Protocol.listner(a);
          log('server:$a');
        }
      }
      buffer = "";
    } else {
      for (String a in sp.getRange(0, sp.length - 1)) {
        if (a.isNotEmpty) {
          Protocol.listner(a);
          log('server:$a');
        }
      }
      buffer = sp.last;
    }
  }

  static Future<String> _decode(data) async => utf8.decode(data);

  // ignore: non_constant_identifier_names
  //function for send loging data to server
  // ignore: non_constant_identifier_names

  // String getServerReply() {
  //   return this.serverResponse;
  // }
}
