import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:scoop/constants/kcalendar.dart';
import 'package:url_launcher/url_launcher.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with AutomaticKeepAliveClientMixin<Calendar> {
  late Offset _tapDownPosition;
  late Map<String, dynamic> data;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore inst = FirebaseFirestore.instance;
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    calendarMap.clear();
    getFutureDocData();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _onDaySelected(_selectedDay!, _focusedDay);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    final calendarEvents = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(calendarMap);
    return calendarEvents[day] ?? [];
  }

  int getHashCode(DateTime? key) {
    return key!.day * 1000000 + key.month * 10000 + key.year;
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  String? getPhone() {
    String? phone = auth.currentUser?.phoneNumber?.substring(3);
    return phone;
  }

  void getFutureDocData() async {
    var documents = await inst.collection('Username').doc(getPhone()).get();
    if (documents.exists) {
      setState(() {
        data = documents.data()!;
        Map step1 = data['MyEvents'];
        List keys = step1.keys.toList();
        for (var i in keys) {
          DateTime dt = DateTime.parse(i);
          Map step2 = step1[i];

          var calendarKey = DateTime.parse(i + ' 00:00:00.000');

          for (var j in step2.keys) {
            if (calendarMap.containsKey(calendarKey)) {
              calendarMap[dt]?.add(
                Event(
                  name: j.replaceAll('%2E', '.'),
                  start_time: step2[j]['start_time'],
                  end_time: step2[j]['end_time'],
                  link: step2[j]['link'],
                ),
              );
            } else {
              calendarMap.putIfAbsent(
                dt,
                () => [
                  Event(
                    name: j.replaceAll('%2E', '.'),
                    start_time: step2[j]['start_time'],
                    end_time: step2[j]['end_time'],
                    link: step2[j]['link'],
                  )
                ],
              );
            }
          }
        }
      });
    }
  }

  // For launching URLs
  Future<void> _launchInBrowser(String link) async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _tapDownPosition = details.globalPosition;
                      },
                      onLongPress: () {
                        final RenderObject? overlay =
                            Overlay.of(context)?.context.findRenderObject();
                        showMenu(
                          context: context,
                          items: <PopupMenuEntry>[
                            PopupMenuItem(
                              child: const Text(
                                'Remove from Calendar',
                              ),
                              onTap: () {
                                //TODO: add code to delete the event and reload this page
                              },
                            ),
                          ],
                          position: RelativeRect.fromLTRB(
                            _tapDownPosition.dx,
                            _tapDownPosition.dy,
                            overlay!.semanticBounds.size.width -
                                _tapDownPosition.dx,
                            overlay.semanticBounds.size.height -
                                _tapDownPosition.dy,
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => _launchInBrowser('${value[index].link}'),
                          title: Text('${value[index].name}'),
                          subtitle: Text(
                            'Start: ${value[index].start_time}\nEnd: ${value[index].end_time}',
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
