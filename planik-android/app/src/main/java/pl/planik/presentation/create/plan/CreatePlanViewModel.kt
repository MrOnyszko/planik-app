package pl.planik.presentation.create.plan

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import pl.planik.app.hilt.DefaultCoroutineDispatcher
import pl.planik.domain.model.NewPlan
import pl.planik.domain.service.PlanService
import pl.planik.presentation.common.StateStatus
import javax.inject.Inject

@HiltViewModel
class CreatePlanViewModel @Inject constructor(
  @DefaultCoroutineDispatcher private val dispatcher: CoroutineDispatcher,
  private val planService: PlanService,
) : ViewModel() {

  private val pendingActions = MutableSharedFlow<CreatePlanAction>()
  private val _state = MutableStateFlow(CreatePlanState())

  val state: StateFlow<CreatePlanState> = _state
    .stateIn(
      scope = viewModelScope,
      started = SharingStarted.Eagerly,
      initialValue = CreatePlanState(),
    )

  init {
    viewModelScope.launch(dispatcher) {
      pendingActions.collect { action ->
        when (action) {
          is CreatePlanAction.PlanNameTextChanges -> applyTextChanges(action)
          CreatePlanAction.UpdatePlanName -> applyPlanNameUpdate()
          CreatePlanAction.Done -> applyDoneAll()
        }
      }
    }

    applyCreatePlan()
  }

  fun submitAction(action: CreatePlanAction) {
    viewModelScope.launch(dispatcher) {
      pendingActions.emit(action)
    }
  }

  private fun applyCreatePlan() {
    viewModelScope.launch(dispatcher) {
      val plan = planService.addPlan(NewPlan(name = ""))
      _state.emit(
        state.value.copy(
          stateStatus = StateStatus.LOADED,
          planId = plan?.id,
          plan = plan,
          name = ""
        )
      )
    }
  }

  private fun applyTextChanges(action: CreatePlanAction.PlanNameTextChanges) {
    viewModelScope.launch(dispatcher) {
      val plan = state.value.plan?.copy(name = action.text)
      _state.emit(state.value.copy(name = action.text, plan = plan))
    }
  }

  private fun applyPlanNameUpdate() {
    viewModelScope.launch(dispatcher) {
      val plan = state.value.plan
      if (plan != null) {
        val updatedPlan = planService.updatePlan(plan)
        _state.emit(state.value.copy(plan = updatedPlan))
      }
    }
  }

  private fun applyDoneAll() {
    viewModelScope.launch(dispatcher) {
      val name = state.value.name
      val plan = state.value.plan?.copy(current = true, name = name)
      if (plan != null) {
        val updatedPlan = planService.updatePlan(plan)
        _state.emit(state.value.copy(plan = updatedPlan, created = true))
      }
    }
  }
}
