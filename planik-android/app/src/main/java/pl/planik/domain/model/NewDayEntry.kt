package pl.planik.domain.model

import java.time.DayOfWeek
import java.time.OffsetTime

data class NewDayEntry(
  val title: String,
  val dayOfWeek: DayOfWeek,
  val start: OffsetTime,
  val end: OffsetTime,
)