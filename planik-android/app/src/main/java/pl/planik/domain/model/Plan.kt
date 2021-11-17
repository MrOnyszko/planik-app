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
    val entry = entries.first { it.start.dayOfWeek == dayOfWeek }
    return entries.indexOf(entry)
  }
}