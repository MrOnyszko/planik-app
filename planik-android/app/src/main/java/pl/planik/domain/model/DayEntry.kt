package pl.planik.domain.model

import java.time.OffsetDateTime

data class DayEntry(
  val id: Int,
  val ordinal: Int,
  val title: String,
  val start: OffsetDateTime,
  val end: OffsetDateTime,
  val pauseMinutes: Int,
)