//reesonse types:
//1.LoginAuthentication
//
import 'dart:convert';
import 'package:hello_world/Classes/User.dart';

import 'ServerResponse/resposes.dart';

class JsonDecoder {
  static dynamic decode(String jsonString) {
    Map<String, dynamic> jsonMap;
    try {
      jsonMap = json.decode(jsonString);
    } catch (e) {
      print('failed to decode respons:"$jsonString"end');
      return;
    }

    //response relavent to loginauthentication
    if (jsonMap['_responseType'] == "LoginAuthentication") {
      return LoginAuthentication(
          jsonMap["_responseType"], jsonMap["_varification"], jsonMap['_role']);
    }

    if (jsonMap['_responseType'] == "RegistrationRespons") {
      return RegistrationRespons(
          jsonMap["_responseType"], jsonMap["_regresult"]);
    }

    if (jsonMap['_responseType'] == "ClientBasicInforRes") {
      Map userData = jsonMap["info"];

      //   User(this._name, this._email, this._role)
      return MyBasicInforRes(
          jsonMap["_responseType"],
          User(userData['_username'], userData['_email'],
              userData['_profileimage'], userData['_role']));
    }

    if (jsonMap['_responseType'] == "LatestNews") {
      //   User(this._name, this._email, this._role)
      //covert list of events maps to list of news objects

      return LastestNewsRes(jsonMap["_responseType"], jsonMap["_latestNews"]);
    }

    if (jsonMap['_responseType'] == "ChatMsg") {
      Map sender = jsonMap["_sender"];
      return IncomingMsgRes(
        jsonMap["_responseType"],
        User(
          sender["_username"],
          sender["_email"],
          sender["_profileimage"],
          sender["_role"],
        ),
        jsonMap["_destination"],
        jsonMap["_data"],
        jsonMap["_time"],
      );
    }

    if (jsonMap['_responseType'] == "CalendarInfo") {
      List events = jsonMap["_calendarEvents"];
      return CalendarInfoRes(jsonMap["_responseType"], events);
    }

    if (jsonMap['_responseType'] == "CourseItems") {
      List courses = jsonMap["courses"];
      return CoursesItemsRes(jsonMap["_responseType"], courses);
    }

    if (jsonMap['_responseType'] == "CourseDocs") {
      List coursesResources = jsonMap["coursesDocs"];
      return CoursesResourcesRes(jsonMap["_responseType"], coursesResources);
    }

    if (jsonMap['_responseType'] == "onlineUsersCount") {
      return OnlineUserCountRes(jsonMap["_responseType"], jsonMap['Count']);
    }
  }
}
