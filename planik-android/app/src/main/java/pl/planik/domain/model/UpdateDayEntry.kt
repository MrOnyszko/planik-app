package pl.planik.domain.model

import java.time.OffsetTime

data class UpdateDayEntry(
  val title: String,
  val start: OffsetTime,
  val end: OffsetTime,
)