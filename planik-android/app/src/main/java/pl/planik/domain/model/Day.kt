package pl.planik.domain.model

import java.time.DayOfWeek
import java.time.OffsetDateTime

data class Day(
  val ordinal: Int,
  val dayOfWeek: DayOfWeek,
  val date: OffsetDateTime,
  val entries: List<DayEntry>
)