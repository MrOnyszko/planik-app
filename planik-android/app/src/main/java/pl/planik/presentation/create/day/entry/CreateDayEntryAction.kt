package pl.planik.presentation.create.day.entry

import java.time.OffsetTime

sealed class CreateDayEntryAction {
  data class DayEntryNameTextChanges(val text: String = "") : CreateDayEntryAction()
  data class DayEntryStartChanges(val value: OffsetTime? = null) : CreateDayEntryAction()
  data class DayEntryEndChanges(val value: OffsetTime? = null) : CreateDayEntryAction()
  object Confirm : CreateDayEntryAction()
}