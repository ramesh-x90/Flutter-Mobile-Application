import 'dart:io';
import 'dart:convert';

import 'package:hello_world/Protocol/Protocol.dart';

import 'Comm.dart';

class Server {
  static String _host = '192.168.1.13';
  static int _port = 65400;
  Socket? socket;
  String serverResponse = "null";
  // ignore: non_constant_identifier_names
  Function set_tap_visibiliy;

  Server(this.set_tap_visibiliy) {
    _connect();
  }

  //make connection to the server
  Future<void> _connect() async {
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
            _socket.destroy();
            socket?.destroy();
          },
        );

        //make available to enter to application
        set_tap_visibiliy(true);
        this.socket = _socket;
        Comm.setserver(this);
        await send();
        break;
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  //sending data to server
  Future<void> send({String msg = 'hello server'}) async {
    socket != null ? print('client:$msg') : print('socket is null');
    socket?.add(utf8.encode(msg));
  }

  //callback function when new data arrived
  Future<void> getServerResponse(data) async {
    this.serverResponse = utf8.decode(data);
    Protocol.listner(this.serverResponse);
    print('server:${this.serverResponse}');
  }

  // ignore: non_constant_identifier_names
  //function for send loging data to server
  // ignore: non_constant_identifier_names
  Future<void> send_logging_data(
      {String name = 'name', String passwd = 'password'}) async {
    this.send(msg: """
              {

              request: logging

              credential: 
                  {	
                    token:
                    username:$name
                    password:$passwd
                  }
              }
              """);
  }

  String getServerReply() {
    return this.serverResponse;
  }

  void sendmsg(
    String reqType, {
    String username = '',
    String toWhom = '',
    String destType = '',
    int destID = 0,
    String title = '',
    String threadID = '',
    String textMsg = '',
  }) {
    this.send(msg: """
request:$reqType

sender:$username

where: {
	type:$destType
	id:$destID
	}

subject: {
	title:$title
	thread id:$threadID
	}

towhom:$toWhom

data: {
	
	images: 
	text:$textMsg

	}
""");
  }
}
