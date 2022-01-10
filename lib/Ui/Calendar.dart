import 'package:flutter/material.dart';
import 'package:hello_world/PopMsgs/PopUpBox.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/Ui/NavDrawer.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  DateTime selectedDate = DateTime.now();
  CalendarController cc = CalendarController();
  // GlobalKey key = GlobalKey<_CalendarState>();

  var selectedEvents = [];

  @override
  void initState() {
    // TODO: implement initState
    Protocol.setupdateCalendarcallBack(() {
      if (this.mounted)
        setState(() {
          selectedEvents.clear();
        });
    });
    reqcalendarInfo();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SfCalendar(
              controller: cc,
              view: CalendarView.month,
              dataSource: MeetingDataSource(Event.getEventsList()),
              allowViewNavigation: false,
              allowedViews: [
                CalendarView.month,
                CalendarView.week,
                CalendarView.day,
                CalendarView.schedule,
              ],
              onSelectionChanged: (calendarSelectionDetails) {
                if (calendarSelectionDetails.date != null)
                  selectedDate = calendarSelectionDetails.date!;
              },
              onTap: (calendarTapDetails) {
                setState(() {
                  selectedEvents = calendarTapDetails.appointments != null
                      ? calendarTapDetails.appointments!
                      : [];
                });
              },
              todayHighlightColor: EnvRes.themeColor,
            ),
          ),

          //////////////// debuging calendar ////////////////
          // ButtonBar(
          //   alignment: MainAxisAlignment.center,
          //   children: [
          //     OutlinedButton(
          //       onPressed: () {
          //         setState(() {
          //           Event(
          //               'Assignment',
          //               "assignment2 - debuging",
          //               selectedDate.toString(),
          //               selectedDate.add(Duration(hours: 2)).toString(),
          //               '',
          //               Colors.red,
          //               false);
          //           selectedEvents.clear();
          //         });
          //       },
          //       child: Icon(Icons.add),
          //     ),
          //     OutlinedButton(
          //       onPressed: () {
          //         setState(() {
          //           reqcalendarInfo();
          //           setState(() {});
          //         });
          //       },
          //       child: Icon(Icons.refresh),
          //     ),
          //     OutlinedButton(
          //       onPressed: () {
          //         setState(() {
          //           selectedEvents.clear();
          //           cc.selectedDate = DateTime.now();
          //         });
          //       },
          //       child: Icon(Icons.today),
          //     ),
          //   ],
          // ),

          //////////////// debuging calendar ////////////////

          Expanded(
              child: Visibility(
            visible: selectedEvents.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  children: [
                    ...selectedEvents.map(
                      (e) {
                        e = e as Event;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                  offset: Offset(2, 3),
                                )
                              ],
                              color: EnvRes.themeColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blueAccent, width: 1),
                            ),
                            child: ListTile(
                              leading: e.eventName == 'Lecture'
                                  ? Icon(
                                      Icons.meeting_room,
                                      color: Colors.white,
                                    )
                                  : (e.eventName == 'Assignment')
                                      ? Icon(
                                          Icons.assignment,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.event,
                                          color: Colors.white,
                                        ),
                              title: Text(
                                e.eventName,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                e.subject,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                calendarPopUpBox(
                                  context,
                                  title: e.eventName,
                                  from: (e.from as DateTime)
                                      .toString()
                                      .substring(0, 19),
                                  to: (e.to as DateTime)
                                      .toString()
                                      .substring(0, 19),
                                  about: e.subject,
                                  url: e.url,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          child: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
      ),
      backgroundColor: EnvRes.dashboardHeadColor,
      title: Text('Calendar'),
      elevation: 20,
      actions: [
        IconButton(
            onPressed: () {
              reqcalendarInfo();
            },
            icon: Icon(Icons.refresh))
      ],
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Event {
  static List<Event> _listOfCalendarEvents = <Event>[];
  String eventName;
  String subject;
  late DateTime from;
  late DateTime to;
  String url;
  Color background;
  bool isAllDay;

  Event(this.eventName, this.subject, String from, String to, this.url,
      this.background, this.isAllDay) {
    this.from = DateTime.parse(from);
    this.to = DateTime.parse(to);

    addToEventsList(this);
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

  static void clearEventsList() {
    _listOfCalendarEvents.clear();
  }

  static void addToEventsList(Event e) {
    _listOfCalendarEvents.add(e);
  }

  static List<Event> getEventsList() {
    return _listOfCalendarEvents;
  }
}
