package pl.planik.presentation.create.day.entry

import java.time.OffsetTime

sealed class CreateDayEntryAction {
  data class DayEntryNameTextChanges(val text: String = "") : CreateDayEntryAction()
  data class DayEntryStartChanges(val value: OffsetTime) : CreateDayEntryAction()
  data class DayEntryEndChanges(val value: OffsetTime) : CreateDayEntryAction()
  object Confirm : CreateDayEntryAction()
}