import 'package:flutter/material.dart';
import 'package:hello_world/Classes/Chat.dart';
import 'package:hello_world/Classes/Course.dart';
import 'package:hello_world/Classes/LatestNews.dart';
import 'package:hello_world/PopMsgs/Toast.dart';
import 'package:hello_world/Protocol/JsonDecoder.dart';
import 'package:hello_world/Protocol/ServerResponse/resposes.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/StateSave/CurrentAppstate.dart';
import 'package:hello_world/Ui/Calendar.dart';

class Protocol {
  /*
  protocol for communication
  
   */

  static const String version = "0.1.1";

  // ignore: non_constant_identifier_names
  static Function? LoginVerficationlistner;
  // ignore: non_constant_identifier_names
  static Function? RegFormResultslistner;

  static Function? incomingmsglistner;

  static Function? dashBoardRefreshCallBack;

  static Function? calendarCallBack;
  static Function? coursesPageCallBack;

  static Function? courseresourcesPageCallbak;
  static Function? publicChatCallbak;

  static void listner(String response) {
    dynamic responseObject = JsonDecoder.decode(response);

    if (responseObject == null) return;
    //msgs related to login
    if (responseObject.getResponseType() == "LoginAuthentication") {
      if (LoginVerficationlistner != null) {
        LoginVerficationlistner!(responseObject);
      }

      switch (responseObject.getVarification()) {
        case 0:
          ShowToast("Login Successful");
          reqMyuserInfo();
          break;
        case -1:
          ShowToast("Password is wrong");
          CurrentAppState.removeSP('password');
          break;
        case -2:
          ShowToast("Username is wrong");
          CurrentAppState.removeSP('username');
          break;
        default:
      }
    }

    //registration response
    if (responseObject.getResponseType() == "RegistrationRespons") {
      if (RegFormResultslistner != null) {
        RegFormResultslistner!(responseObject.getRegResults());
      }
    }

    if (responseObject.getResponseType() == "ClientBasicInforRes") {
      CurrentAppState.setCurrentUser(responseObject.getMyInfo());
    }

    if (responseObject.getResponseType() == "LatestNews") {
      LatestNews.clearLatestNews();

      for (Map i in responseObject.getnews()) {
        LatestNews(i['_title'], i['_imageURL'], i['body'], i["postedtime"]);
      }
      dashBoardRefreshCallBack!();
    }

    if (responseObject.getResponseType() == "ChatMsg") {
      LatestNews.clearLatestNews();

      Chat(responseObject.getSender(), responseObject.getData(),
          responseObject.getDes(), responseObject.getTime());
      if (incomingmsglistner != null) {
        incomingmsglistner!();
      }
    }

    if (responseObject.getResponseType() == "CalendarInfo") {
      Event.clearEventsList();
      for (Map event in (responseObject as CalendarInfoRes).getEvents()) {
        String eventName = event['_title'];
        Color color = (eventName == 'Assignment') ? Colors.red : Colors.green;
        Event(eventName, event['_subject'], event['_from'], event['_to'],
            event['_url'], color, false);
      }
      calendarCallBack!();
    }

    if (responseObject.getResponseType() == "CourseItems") {
      Courses.clearCourese();
      for (Map course in (responseObject as CoursesItemsRes).getCorses()) {
        Course(course['iD'], course['modulename'], course['moduleOwner']);
      }
      coursesPageCallBack!();
    }

    if (responseObject.getResponseType() == "CourseDocs") {
      bool clean = false;
      for (Map doc in (responseObject as CoursesResourcesRes).getresources()) {
        Course course;

        try {
          course = Courses.getCourseByID(doc['moduleiD']);
          if (!clean) {
            course.getCourseDocs().clear();
            clean = true;
          }
          List<String> list = [];
          for (String urls in doc['resources']) list.add(urls);
          course.addDoc(CourseDoc(
            doc['title'],
            list,
            doc['Description'],
          ));
        } catch (e) {
          ShowToast(e.toString());
          print(e.toString());
        }
      }
      courseresourcesPageCallbak!();
    }

    if (responseObject.getResponseType() == "onlineUsersCount") {
      CurrentAppState.onlineUserCount = responseObject.getCount();
      if (publicChatCallbak != null)
        publicChatCallbak!(CurrentAppState.onlineUserCount);
    }
  }

  //login page listner for open menu
  static void setloginpagelistner(Function fn) {
    LoginVerficationlistner = fn;
  }

  //for registration results
  static void setRegFormResultslistner(Function fn) {
    RegFormResultslistner = fn;
  }

  static void setincomingmsglistner(Function fn) {
    incomingmsglistner = fn;
  }

  static void setDashBoardRefreshCallBack(void Function() refresh) {
    dashBoardRefreshCallBack = refresh;
  }

  static void setupdateCalendarcallBack(void Function() refresh) {
    calendarCallBack = refresh;
  }

  static void setupCoursePagecallBack(void Function() fn) {
    coursesPageCallBack = fn;
  }

  static void setCourseResourcesPageCallBack(void Function() fn) {
    courseresourcesPageCallbak = fn;
  }

  static void publicChatListner(Function fn) {
    publicChatCallbak = fn;
  }
}
