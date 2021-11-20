package pl.planik.domain.model

import java.time.DayOfWeek
import java.time.OffsetDateTime

data class Plan(
  val id: Int,
  val name: String,
  val current: Boolean,
  val archived: Boolean,
  val createdAt: OffsetDateTime,
  val days: List<Day>,
) {
  fun entryIndexForDayOfWeek(dayOfWeek: DayOfWeek): Int {
    val entries = days.flatMap { it.entries }
    val entry = entries.firstOrNull { it.start.dayOfWeek == dayOfWeek } ?: return 0
    return entries.indexOf(entry)
  }

  fun dayIndexForDayOfWeek(dayOfWeek: DayOfWeek): Int {
    return days.indexOfFirst { it.dayOfWeek == dayOfWeek }
  }
}