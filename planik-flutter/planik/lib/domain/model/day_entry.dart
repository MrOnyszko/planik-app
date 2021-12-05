import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_entry.freezed.dart';

@freezed
class DayEntry with _$DayEntry {
  const factory DayEntry({
    required int id,
    required int dayOfWeek,
    required String title,
    required DateTime start,
    required DateTime end,
    required int pauseMinutes,
  }) = _DayEntry;
}
