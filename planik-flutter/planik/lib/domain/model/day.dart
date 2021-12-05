import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/model/day_entry.dart';

part 'day.freezed.dart';

@freezed
class Day with _$Day {
  const factory Day({
    required int ordinal,
    required String name,
    required DateTime date,
    required List<DayEntry> entries,
  }) = _Day;
}
