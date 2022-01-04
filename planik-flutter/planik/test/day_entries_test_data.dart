import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';

var mathDayEntry = DayEntry(
  id: 1,
  dayOfWeek: DateTime.monday,
  title: 'Math',
  start: DateTime.utc(2020, 7, 6, 8),
  end: DateTime.utc(2020, 7, 6, 8, 45),
  pauseMinutes: 15,
);

var historyDayEntry = DayEntry(
  id: 2,
  dayOfWeek: DateTime.monday,
  title: 'History',
  start: DateTime.utc(2020, 7, 6, 9),
  end: DateTime.utc(2020, 7, 6, 9, 45),
  pauseMinutes: 5,
);

var latinDayEntry = DayEntry(
  id: 3,
  dayOfWeek: DateTime.monday,
  title: 'Latin',
  start: DateTime.utc(2020, 7, 6, 9, 50),
  end: DateTime.utc(2020, 7, 6, 10, 30),
  pauseMinutes: 5,
);

var monday = Day(
  ordinal: 0,
  name: 'Monday',
  date: DateTime.utc(2020, 7, 6),
  entries: [
    mathDayEntry,
    historyDayEntry,
  ],
);

var tuesday = Day(
  ordinal: 1,
  name: 'Tuesday',
  date: DateTime.utc(2020, 7, 7),
  entries: [
    mathDayEntry,
    historyDayEntry,
    latinDayEntry,
  ],
);

var days = [
  monday,
  tuesday,
];
