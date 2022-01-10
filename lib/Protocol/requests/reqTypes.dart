import 'dart:io';

import 'package:hello_world/Classes/Chat.dart';

class Req {
  //req types- logingreq , send_massage
  final String _requestType;

  Req(this._requestType);

  getReqType() => this._requestType;

  Map<String, dynamic> toJson() {
    return ({
      "reqType": this.getReqType(),
    });
  }
}

class LoginReq extends Req {
  final String _username;
  final String _password;

  LoginReq(String requestType, this._username, this._password)
      : super(requestType);

  @override
  Map<String, dynamic> toJson() {
    return ({
      "reqType": this.getReqType(),
      "_username": this._username,
      "_password": this._password,
    });
  }
}

// ignore: todo
//TODO: FTP "_profileimage": "base64" has to change to "_profileimage": base64

class RegistrationReq extends Req {
  final String _username;
  final String _email;
  final String _password;
  // ignore: avoid_init_to_null
  File? profileimage = null;
  final String role;

  RegistrationReq(String requestType, this._username, this._email,
      this._password, this.role,
      {this.profileimage})
      : super(requestType);

  @override
  Map<String, dynamic> toJson() {
    int hasimage = 0;

    hasimage = (profileimage == null) ? 0 : 1;

    return ({
      "reqType": this.getReqType(),
      "_username": this._username,
      "_email": this._email,
      "_password": this._password,
      "_profileimage": hasimage,
      "_role": this.role,
    });
  }
}

class SendMsgReq extends Req {
  Chat meg;
  SendMsgReq(
    String requestType,
    this.meg,
  ) : super(requestType);

  @override
  Map<String, dynamic> toJson() {
    return ({
      "reqType": this.getReqType(),
      "message": this.meg,
    });
  }
}

class CourseDocsReq extends Req {
  String moduleiD;

  CourseDocsReq(
    String requestType,
    this.moduleiD,
  ) : super(requestType);

  @override
  Map<String, dynamic> toJson() {
    return ({
      "reqType": this.getReqType(),
      "moduleiD": this.moduleiD,
    });
  }
}
