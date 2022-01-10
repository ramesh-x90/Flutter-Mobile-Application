import 'package:hello_world/Classes/User.dart';

class ServerResponse {
  late final String _responseType;

  ServerResponse(this._responseType);

  String getResponseType() => this._responseType;
}

class LoginAuthentication extends ServerResponse {
  int _varification = -2;
  String role;
  LoginAuthentication(String type, this._varification, this.role) : super(type);

  int getVarification() => this._varification;
  String getRole() => this.role;
}

class RegistrationRespons extends ServerResponse {
  int _results = -2;
  RegistrationRespons(String type, this._results) : super(type);

  int getRegResults() => this._results;
}

class MyBasicInforRes extends ServerResponse {
  User _myInfo;
  MyBasicInforRes(String type, this._myInfo) : super(type);

  User getMyInfo() => this._myInfo;
}

class LastestNewsRes extends ServerResponse {
  final List<dynamic> _events;

  LastestNewsRes(String type, this._events) : super(type);

  List getnews() => this._events;
}

class IncomingMsgRes extends ServerResponse {
  final User sender;
  final String des;
  final String data;
  final String time;

  IncomingMsgRes(String type, this.sender, this.des, this.data, this.time)
      : super(type);

  User getSender() => this.sender;
  String getDes() => this.des;
  String getData() => this.data;
  String getTime() => this.time;
}

class CalendarInfoRes extends ServerResponse {
  List _events;
  CalendarInfoRes(String type, this._events) : super(type);
  List getEvents() => this._events;
}

class CoursesItemsRes extends ServerResponse {
  List _courses;
  CoursesItemsRes(String type, this._courses) : super(type);
  List getCorses() => this._courses;
}

class CoursesResourcesRes extends ServerResponse {
  List _docs;
  CoursesResourcesRes(String type, this._docs) : super(type);
  List getresources() => this._docs;
}

class OnlineUserCountRes extends ServerResponse {
  int count;
  OnlineUserCountRes(String type, this.count) : super(type);
  int getCount() => this.count;
}
