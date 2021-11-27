package pl.planik.presentation.create.plan

import androidx.compose.runtime.Immutable
import pl.planik.domain.model.Day
import pl.planik.domain.model.Plan
import pl.planik.presentation.common.StateStatus

@Immutable
data class CreatePlanState(
  val stateStatus: StateStatus = StateStatus.EMPTY,
  val name: String = "",
  val plan: Plan? = null,
  val planId: Int? = null,
  val dayEntryInput: String? = null,
  val showThankYouScreen: Boolean = false
) {
  val days: List<Day> = plan?.days ?: emptyList()

  val doneAllVisible = !showThankYouScreen && planId == null

  val isFabVisible = !showThankYouScreen
}