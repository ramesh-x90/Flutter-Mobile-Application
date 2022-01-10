import 'Server.dart';

/*
this class is for save connections staticaly
 */

class Comm {
  static Server? server;

  // static Server? getServer() => server;

  static void setserver(Server s) {
    server = s;
  }
}
