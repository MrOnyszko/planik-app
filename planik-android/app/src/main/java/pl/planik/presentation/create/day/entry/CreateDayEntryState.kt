package pl.planik.presentation.create.day.entry

import androidx.compose.runtime.Immutable
import java.time.DayOfWeek
import java.time.OffsetTime

@Immutable
data class CreateDayEntryState(
  val currentDayOfWeek: DayOfWeek = DayOfWeek.MONDAY,
  val planId: Int? = null,
  val dayEntryName: String? = null,
  val dayEntryStart: OffsetTime? = null,
  val dayEntryEnd: OffsetTime? = null,
  val created: Boolean = false,
) {

  val hasDayEntryName = dayEntryName?.isNotBlank() == true

  val hasDayEntryStart = dayEntryStart != null

  val hasDayEntryEnd = dayEntryEnd != null

  val isDayEntryEndNotBeforeStart = dayEntryStart?.let { dayEntryEnd?.isBefore(it) } == false

  val isDayEntryFormValid = hasDayEntryName
    && hasDayEntryStart
    && hasDayEntryEnd
    && isDayEntryEndNotBeforeStart

}