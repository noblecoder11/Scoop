final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 2, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 2, kToday.month, kToday.day);

class Event {
  String? name;
  String? start_time;
  String? end_time;
  String? link;

  Event({this.name, this.start_time, this.end_time, this.link});
  Event.fromJson(var event) {
    this.name = event['name'];
    this.start_time = event['start_time'];
    this.end_time = event['end_time'];
    this.link = event['link'];
  }
}

Map<DateTime?, List<Event>> calendarMap = {};
