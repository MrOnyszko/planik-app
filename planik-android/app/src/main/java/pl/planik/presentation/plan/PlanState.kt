package pl.planik.presentation.plan

import pl.planik.domain.model.Day
import pl.planik.domain.model.Plan
import pl.planik.presentation.common.StateStatus

data class PlanState(
  val stateStatus: StateStatus = StateStatus.LOADING,
  val plan: Plan? = null,
  val indexOfCurrentDayEntry: Int? = null,
  val indexOfCurrentDay: Int? = null,
  val isVertical: Boolean = true,
) {
  val days: List<Day> = plan?.days ?: emptyList()
}