package pl.planik.presentation.create.plan

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.stateIn
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
  private val arguments: CreatePlanRouteArguments,
) : ViewModel() {

  private val pendingActions = MutableSharedFlow<CreatePlanAction>()
  private val _state = MutableStateFlow(CreatePlanState())

  val state: StateFlow<CreatePlanState> = _state
    .stateIn(
      scope = viewModelScope,
      started = SharingStarted.WhileSubscribed(5000),
      initialValue = CreatePlanState(),
    )

  init {
    viewModelScope.launch(dispatcher) {
      pendingActions.collect { action ->
        when (action) {
          is CreatePlanAction.PlanNameTextChanges -> applyTextChanges(action)
          is CreatePlanAction.DayOfWeekChanges -> applyDayOfWeekChanges(action)
          CreatePlanAction.UpdatePlanName -> applyPlanNameUpdate()
          CreatePlanAction.Done -> applyDoneAll()
        }
      }
    }

    loadOrCreate()
  }

  fun submitAction(action: CreatePlanAction) {
    viewModelScope.launch(dispatcher) {
      pendingActions.emit(action)
    }
  }

  private fun loadOrCreate() {
    val planId = arguments.planId
    if (planId != null) {
      applyObservingPlan(planId)
    } else {
      applyCreateAndObservePlan()
      _state.value.plan?.id?.let { id ->
        applyObservingPlan(id)
      }
    }
  }

  private fun applyCreateAndObservePlan() {
    viewModelScope.launch(dispatcher) {
      _state.emit(state.value.copy(stateStatus = StateStatus.LOADING))
      val newPlan = planService.addPlan(NewPlan())
      if (newPlan?.id != null) {
        planService.observePlan(newPlan.id).collect { plan ->
          _state.emit(
            state.value.copy(
              stateStatus = StateStatus.LOADED,
              planId = plan?.id,
              plan = plan,
              planName = plan?.name ?: ""
            )
          )
        }
      }
    }
  }

  private fun applyObservingPlan(id: Int) {
    viewModelScope.launch(dispatcher) {
      _state.emit(state.value.copy(stateStatus = StateStatus.LOADING))
      planService.observePlan(id).collect { plan ->
        _state.emit(
          state.value.copy(
            stateStatus = StateStatus.LOADED,
            planId = plan?.id,
            plan = plan,
            planName = plan?.name ?: ""
          )
        )
      }
    }
  }

  private fun applyTextChanges(action: CreatePlanAction.PlanNameTextChanges) {
    viewModelScope.launch(dispatcher) {
      val plan = state.value.plan?.copy(name = action.text)
      _state.emit(state.value.copy(planName = action.text, plan = plan))
    }
  }

  private fun applyDayOfWeekChanges(action: CreatePlanAction.DayOfWeekChanges) {
    viewModelScope.launch(dispatcher) {
      _state.emit(state.value.copy(currentDayOfWeek = action.value))
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
      val name = state.value.planName
      val plan = state.value.plan?.copy(current = true, name = name)
      if (plan != null) {
        val updatedPlan = planService.updatePlan(plan)
        _state.emit(state.value.copy(plan = updatedPlan, isThankYouVisible = true))
      }
    }
  }
}
