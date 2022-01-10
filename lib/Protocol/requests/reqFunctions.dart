import 'dart:convert';

import 'package:hello_world/Classes/Chat.dart';
import 'package:hello_world/NetWorking/Comm.dart';
import 'package:hello_world/NetWorking/Server.dart';
import 'package:hello_world/Protocol/requests/reqTypes.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

void reqLoging(String userName, String passwd) async {
  // Comm.getServer()!
  // .send(msg: json.encode(LoginReq(EnvRes.loginReq, userName, passwd)));
  Server.send(msg: json.encode(LoginReq(EnvRes.loginReq, userName, passwd)));
}

void reqMyuserInfo() async {
  Server.send(msg: json.encode(Req(EnvRes.reqMyUserInfo)));
}

void reqLatestNews() async {
  Server.send(msg: json.encode(Req(EnvRes.reqLatestNews)));
}

void sendMsg(Chat chat) async {
  Server.send(msg: json.encode(SendMsgReq(EnvRes.sendmsgreq, chat)));
}

void reqcalendarInfo() async {
  Server.send(msg: json.encode(Req(EnvRes.reqcalendarInfo)));
}

void reqCourseItems() async {
  Server.send(msg: json.encode(Req(EnvRes.reqCourseItems)));
}

void reqcourseDocs(String moduleiD) async {
  Server.send(msg: json.encode(CourseDocsReq(EnvRes.reqcourseDocs, moduleiD)));
}
