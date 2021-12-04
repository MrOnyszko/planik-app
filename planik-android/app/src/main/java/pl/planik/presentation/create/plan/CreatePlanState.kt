package pl.planik.presentation.create.plan

import androidx.compose.runtime.Immutable
import pl.planik.domain.model.Day
import pl.planik.domain.model.Plan
import pl.planik.presentation.common.StateStatus
import java.time.DayOfWeek
import java.time.OffsetTime

@Immutable
data class CreatePlanState(
  val stateStatus: StateStatus = StateStatus.EMPTY,
  val currentDayOfWeek: DayOfWeek = DayOfWeek.MONDAY,
  val isThankYouVisible: Boolean = false,
  val planName: String = "",
  val plan: Plan? = null,
  val planId: Int? = null,
  val dayEntryName: String? = null,
  val dayEntryStart: OffsetTime? = null,
  val dayEntryEnd: OffsetTime? = null,
  val isDayEntryErrorVisible: Boolean = false,
) {
  val days: List<Day> = plan?.days ?: emptyList()

  val doneAllVisible = !isThankYouVisible && planId == null

}