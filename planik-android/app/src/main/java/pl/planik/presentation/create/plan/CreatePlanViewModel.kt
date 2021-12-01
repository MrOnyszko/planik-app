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
import pl.planik.domain.model.NewDayEntry
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
          is CreatePlanAction.DayEntryNameTextChanges -> applyDayEntryTextChanges(action)
          is CreatePlanAction.DayEntryEndChanges -> applyDayEntryEndChanges(action)
          is CreatePlanAction.DayEntryStartChanges -> applyDayEntryStartChanges(action)
          is CreatePlanAction.DayOfWeekChanges -> applyDayOfWeekChanges(action)
          CreatePlanAction.UpdatePlanName -> applyPlanNameUpdate()
          CreatePlanAction.AddDayEntry -> applyAddEntry()
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
      applyLoadPlan(planId)
    } else {
      applyCreatePlan()
    }
  }

  private fun applyCreatePlan() {
    viewModelScope.launch(dispatcher) {
      _state.emit(state.value.copy(stateStatus = StateStatus.LOADING))
      val plan = planService.addPlan(NewPlan())
      _state.emit(
        state.value.copy(
          stateStatus = StateStatus.LOADED,
          plan = plan,
        )
      )
    }
  }

  private fun applyLoadPlan(id: Int) {
    viewModelScope.launch(dispatcher) {
      _state.emit(state.value.copy(stateStatus = StateStatus.LOADING))

      val plan = planService.getPlan(id)
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

  private fun applyTextChanges(action: CreatePlanAction.PlanNameTextChanges) {
    viewModelScope.launch(dispatcher) {
      val plan = state.value.plan?.copy(name = action.text)
      _state.emit(state.value.copy(planName = action.text, plan = plan))
    }
  }

  private fun applyDayEntryTextChanges(action: CreatePlanAction.DayEntryNameTextChanges) {
    viewModelScope.launch(dispatcher) {
      _state.emit(state.value.copy(dayEntryName = action.text))
    }
  }

  private fun applyDayEntryStartChanges(action: CreatePlanAction.DayEntryStartChanges) {
    viewModelScope.launch(dispatcher) {
      _state.emit(
        _state.value.copy(dayEntryStart = action.value)
      )
    }
  }

  private fun applyDayEntryEndChanges(action: CreatePlanAction.DayEntryEndChanges) {
    viewModelScope.launch(dispatcher) {
      _state.emit(
        _state.value.copy(dayEntryEnd = action.value)
      )
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

  private fun applyAddEntry() {
    viewModelScope.launch(dispatcher) {
      if (state.value.isDayEntryFormValid) {
        val planId = state.value.planId ?: return@launch
        val newDayEntry = NewDayEntry(
          title = state.value.dayEntryName ?: return@launch,
          dayOfWeek = state.value.currentDayOfWeek,
          start = state.value.dayEntryStart ?: return@launch,
          end = state.value.dayEntryEnd ?: return@launch,
        )
        planService.addDayEntry(planId, newDayEntry)
        _state.emit(
          state.value.copy(
            dayEntryName = null,
            dayEntryStart = null,
            dayEntryEnd = null,
          )
        )
        applyLoadPlan(planId)
      } else {
        _state.emit(state.value.copy(isDayEntryErrorVisible = !state.value.isDayEntryFormValid))
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
