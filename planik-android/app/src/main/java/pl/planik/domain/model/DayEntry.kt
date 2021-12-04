package pl.planik.domain.model

import java.time.DayOfWeek
import java.time.OffsetDateTime

data class DayEntry(
  val id: Int,
  val dayOfWeek: DayOfWeek,
  val title: String,
  val start: OffsetDateTime,
  val end: OffsetDateTime,
  val pauseMinutes: Int,
)