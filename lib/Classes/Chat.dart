import 'package:hello_world/Classes/User.dart';

class Chat {
  final User _sender;
  final dynamic _data;
  final String _destination;
  final String _time;
  static List<Chat> _chats = [];

  Chat(this._sender, this._data, this._destination, this._time) {
    Chat._chats.insert(0, this);
  }

  User getsender() => this._sender;

  dynamic getdata() => this._data;

  String getdestination() => this._destination;
  String getTime() => this._time;

  static List<Chat> getchats() => Chat._chats;

  static void clearchat() {
    _chats.clear();
  }

  Map<String, dynamic> toJson() {
    return ({
      "_sender": this._sender,
      "_data": this._data,
      "_destination": this._destination,
      "_time": this._time,
    });
  }
}
