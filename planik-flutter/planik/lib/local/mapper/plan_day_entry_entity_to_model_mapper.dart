import 'package:planik/domain/model/day_entry.dart';
import 'package:planik/local/entity/plan_day_entry_entity.dart';
import 'package:planik/local/mapper/mapper.dart';

class PlayDayEntryEntityToModelMapper implements Mapper<PlanDayEntryEntity, DayEntry> {
  const PlayDayEntryEntityToModelMapper();

  @override
  DayEntry map(PlanDayEntryEntity value) {
    return DayEntry(
      id: value.id!,
      dayOfWeek: value.dayOfWeek,
      title: value.name,
      start: DateTime.parse(value.start),
      end: DateTime.parse(value.end),
      pauseMinutes: 0,
    );
  }
}
