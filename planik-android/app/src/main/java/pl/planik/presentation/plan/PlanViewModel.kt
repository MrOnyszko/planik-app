@file:Suppress("CanBeParameter")

package pl.planik.presentation.plan

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import pl.planik.app.hilt.DefaultCoroutineDispatcher
import pl.planik.domain.service.PlanService
import pl.planik.presentation.common.StateStatus
import java.time.OffsetDateTime
import javax.inject.Inject

@HiltViewModel
class PlanViewModel @Inject constructor(
  @DefaultCoroutineDispatcher private val dispatcher: CoroutineDispatcher,
  private val planService: PlanService
) : ViewModel() {

  private val pendingActions = MutableSharedFlow<PlanAction>()
  private val _state = MutableStateFlow(PlanState())

  val state: StateFlow<PlanState> = _state.combine(
    planService.getCurrentPlan()
  ) { state, plan ->
    state.copy(
      stateStatus = if (plan == null) StateStatus.EMPTY else StateStatus.LOADED,
      plan = plan,
    )
  }.stateIn(
    scope = viewModelScope,
    started = SharingStarted.WhileSubscribed(5000),
    initialValue = PlanState(),
  )

  init {
    viewModelScope.launch(dispatcher) {
      pendingActions.collect { action ->
        when (action) {
          PlanAction.Today -> {
            viewModelScope.launch {
              val dayOfWeek = OffsetDateTime.now().dayOfWeek
              val indexOfCurrentDayEntry = state.value.plan?.entryIndexForDayOfWeek(dayOfWeek)
              val indexOfCurrentDay = state.value.plan?.dayIndexForDayOfWeek(dayOfWeek)
              _state.emit(
                state.value.copy(
                  indexOfCurrentDayEntry = indexOfCurrentDayEntry,
                  indexOfCurrentDay = indexOfCurrentDay,
                )
              )
              delay(300)
              _state.emit(
                state.value.copy(
                  indexOfCurrentDayEntry = null,
                  indexOfCurrentDay = null,
                )
              )
            }
          }
          PlanAction.TogglePlanViewType -> {
            viewModelScope.launch {
              _state.emit(
                state.value.copy(
                  isVertical = !state.value.isVertical
                )
              )
            }
          }
        }
      }
    }
  }

  fun submitAction(action: PlanAction) {
    viewModelScope.launch(dispatcher) {
      pendingActions.emit(action)
    }
  }
}