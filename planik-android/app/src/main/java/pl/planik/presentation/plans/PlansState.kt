package pl.planik.presentation.plans

import pl.planik.presentation.common.StateStatus

data class PlansState(
  val stateStatus: StateStatus = StateStatus.LOADED
)