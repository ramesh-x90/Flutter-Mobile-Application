class LatestNews {
  static List<LatestNews> _eventslist = [];

  String eventTitle;
  String resURL;
  String newsBody;
  bool favorite = false;
  String date;
  static String filter = '';

  LatestNews(this.eventTitle, this.resURL, this.newsBody, this.date) {
    addLatestNews(this);
  }

  static List<LatestNews> getLatestNews() => _eventslist;

  static void addLatestNews(LatestNews ln) {
    _eventslist.add(ln);
  }

  static void clearLatestNews() {
    _eventslist.clear();
  }

  void setFavorit(bool foo) {
    this.favorite = foo;
  }

  static void setFilter(String f) {
    filter = f;
  }

  static List<LatestNews> getfiltedEvents() {
    if (filter == '') {
      return _eventslist;
    }
    return _eventslist
        .where((element) =>
            element.eventTitle.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }
}
