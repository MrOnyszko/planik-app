package pl.planik.presentation.create.day.entry

import androidx.compose.runtime.Immutable
import pl.planik.presentation.common.StateStatus
import java.time.DayOfWeek
import java.time.OffsetTime

@Immutable
data class CreateDayEntryState(
  val stateStatus: StateStatus = StateStatus.EMPTY,
  val currentDayOfWeek: DayOfWeek = DayOfWeek.MONDAY,
  val planId: Int? = null,
  val dayEntryId: Int? = null,
  val title: String = "",
  val start: OffsetTime? = null,
  val end: OffsetTime? = null,
  val created: Boolean = false,
) {
  private val hasDayEntryName = title.isNotBlank()

  private val hasDayEntryStart = start != null

  private val hasDayEntryEnd = end != null

  private val isDayEntryEndNotBeforeStart = start?.let { end?.isBefore(it) } == false

  val isDayEntryFormValid = hasDayEntryName
    && hasDayEntryStart
    && hasDayEntryEnd
    && isDayEntryEndNotBeforeStart

  val isEditMode = dayEntryId != null
}