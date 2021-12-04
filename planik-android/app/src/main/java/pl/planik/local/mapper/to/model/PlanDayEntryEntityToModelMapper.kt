package pl.planik.local.mapper.to.model

import pl.planik.domain.model.DayEntry
import pl.planik.local.entity.PlanDayEntryEntity
import pl.planik.local.mapper.Mapper
import java.time.DayOfWeek
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class PlanDayEntryEntityToModelMapper @Inject constructor() : Mapper<PlanDayEntryEntity, DayEntry> {
  override fun map(value: PlanDayEntryEntity): DayEntry {
    return DayEntry(
      id = value.id,
      dayOfWeek = DayOfWeek.of(value.dayOfWeek),
      title = value.title,
      start = value.start,
      end = value.end,
      pauseMinutes = 0
    )
  }
}