final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 2, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 2, kToday.month, kToday.day);

class Event {
  String? name;
  String? start_time;
  String? end_time;
  String? link;

  Event({this.name, this.start_time, this.end_time, this.link});
}

Map<DateTime?, List<Event>> calendarMap = {
  // DateTime.parse('20220506'): [
  //   Event(
  //       name: 'name',
  //       start_time: 'now',
  //       end_time: 'aftersometime',
  //       link: 'idc'),
  //   Event(
  //       name: 'name2',
  //       start_time: 'now',
  //       end_time: 'aftersometime',
  //       link: 'idc')
  // ],
  // DateTime.parse('20220508'): [
  //   Event(
  //       name: 'datname',
  //       start_time: 'now',
  //       end_time: 'aftersometime',
  //       link: 'idc'),
  //   Event(
  //       name: 'datname2',
  //       start_time: 'now',
  //       end_time: 'aftersometime',
  //       link: 'idc'),
  //   Event(
  //       name: 'datname2',
  //       start_time: 'now',
  //       end_time: 'aftersometime',
  //       link: 'idc')
  // ],
};
