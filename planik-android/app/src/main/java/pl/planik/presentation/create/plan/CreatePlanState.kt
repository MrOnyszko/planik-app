package pl.planik.presentation.create.plan

import androidx.compose.runtime.Immutable
import pl.planik.presentation.common.StateStatus

@Immutable
data class CreatePlanState(
  val name: String = "",
  val stateStatus: StateStatus = StateStatus.LOADED,
  val created: Boolean = true
)