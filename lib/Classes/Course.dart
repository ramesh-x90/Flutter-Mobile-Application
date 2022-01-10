class Course {
  late String _iD;
  late String _name;
  late String _moduleOwner;
  List<CourseDoc> _docs = [];

  Course(this._iD, this._name, this._moduleOwner) {
    Courses.addCourse(this);
  }

  String getId() => this._iD;
  String getName() => this._name;
  String getModuleOwner() => this._moduleOwner;
  List<CourseDoc> getCourseDocs() => this._docs;

  void addDoc(CourseDoc doc) {
    _docs.add(doc);
  }

  void clearDocs() {
    _docs.clear();
  }
}

class CourseDoc {
  late String _title;
  List<String> _urls = [];
  String _note;

  CourseDoc(this._title, this._urls, this._note);
  String getTitle() => this._title;
  String getNote() => this._note;
  List<String> getUrls() => this._urls;
}

class Courses {
  static Set<Course> _subscribedCourses = {};

  static void addCourse(Course course) {
    _subscribedCourses.add(course);
  }

  static Set<Course> getCourses() => _subscribedCourses;

  static void clearCourese() => _subscribedCourses.clear();

  static Course getCourseByID(String id) {
    return _subscribedCourses.firstWhere((element) => element._iD == id);
  }
}
