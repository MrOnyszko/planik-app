package pl.planik.presentation.plan

import pl.planik.domain.model.Day
import pl.planik.domain.model.Plan
import pl.planik.presentation.common.StateStatus

data class PlanState(
  val stateStatus: StateStatus = StateStatus.LOADING,
  val plan: Plan? = null,
  val indexOfCurrentDay: Int? = null,
) {
  val days: List<Day> = plan?.days ?: emptyList()
}