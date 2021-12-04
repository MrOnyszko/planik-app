package pl.planik.presentation.create.day.entry

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
import pl.planik.domain.model.UpdateDayEntry
import pl.planik.domain.service.PlanService
import pl.planik.presentation.common.StateStatus
import javax.inject.Inject

@HiltViewModel
class CreateDayEntryViewModel @Inject constructor(
  @DefaultCoroutineDispatcher private val dispatcher: CoroutineDispatcher,
  private val planService: PlanService,
  private val arguments: CreateDayEntryRouteArguments,
) : ViewModel() {

  private val initialState = CreateDayEntryState(
    planId = arguments.planId,
    currentDayOfWeek = arguments.dayOfWeek,
    dayEntryId = arguments.dayEntryId,
  )

  private val pendingActions = MutableSharedFlow<CreateDayEntryAction>()
  private val _state = MutableStateFlow(initialState)

  val state: StateFlow<CreateDayEntryState> = _state
    .stateIn(
      scope = viewModelScope,
      started = SharingStarted.WhileSubscribed(5000),
      initialValue = initialState
    )

  init {
    viewModelScope.launch(dispatcher) {
      pendingActions.collect { action ->
        when (action) {
          CreateDayEntryAction.Confirm -> {
            if (_state.value.isEditMode) {
              applyUpdateEntry()
            } else {
              applyAddEntry()
            }
          }
          is CreateDayEntryAction.DayEntryEndChanges -> applyDayEntryEndChanges(action)
          is CreateDayEntryAction.DayEntryNameTextChanges -> applyDayEntryTextChanges(action)
          is CreateDayEntryAction.DayEntryStartChanges -> applyDayEntryStartChanges(action)
        }
      }
    }

    loadDayEntryInEditMode()
  }

  private fun loadDayEntryInEditMode() {
    if (_state.value.isEditMode) {
      loadDayEntry()
    } else {
      viewModelScope.launch(dispatcher) {
        _state.emit(state.value.copy(stateStatus = StateStatus.LOADED))
      }
    }
  }

  private fun loadDayEntry() {
    viewModelScope.launch(dispatcher) {
      _state.emit(state.value.copy(stateStatus = StateStatus.LOADING))
      val dayEntryId = _state.value.dayEntryId ?: return@launch
      val planId = _state.value.planId ?: return@launch
      val dayEntry = planService.getDayEntry(dayEntryId, planId)
      if (dayEntry != null) {
        _state.emit(
          _state.value.copy(
            stateStatus = StateStatus.LOADED,
            currentDayOfWeek = dayEntry.dayOfWeek,
            title = dayEntry.title,
            start = dayEntry.start.toOffsetTime(),
            end = dayEntry.end.toOffsetTime()
          )
        )
      }
    }
  }

  fun submitAction(action: CreateDayEntryAction) {
    viewModelScope.launch(dispatcher) {
      pendingActions.emit(action)
    }
  }

  private fun applyDayEntryTextChanges(action: CreateDayEntryAction.DayEntryNameTextChanges) {
    viewModelScope.launch(dispatcher) {
      _state.emit(state.value.copy(title = action.text))
    }
  }

  private fun applyDayEntryStartChanges(action: CreateDayEntryAction.DayEntryStartChanges) {
    viewModelScope.launch(dispatcher) {
      _state.emit(
        _state.value.copy(start = action.value)
      )
    }
  }

  private fun applyDayEntryEndChanges(action: CreateDayEntryAction.DayEntryEndChanges) {
    viewModelScope.launch(dispatcher) {
      _state.emit(
        _state.value.copy(end = action.value)
      )
    }
  }

  private fun applyAddEntry() {
    viewModelScope.launch(dispatcher) {
      val planId = state.value.planId ?: return@launch
      val newDayEntry = NewDayEntry(
        title = state.value.title,
        dayOfWeek = state.value.currentDayOfWeek,
        start = state.value.start ?: return@launch,
        end = state.value.end ?: return@launch,
      )
      planService.addDayEntry(planId, newDayEntry)
      _state.emit(state.value.copy(created = true))
    }
  }

  private fun applyUpdateEntry() {
    viewModelScope.launch(dispatcher) {
      val planId = state.value.planId ?: return@launch
      val dayEntryId = state.value.dayEntryId ?: return@launch
      val newDayEntry = UpdateDayEntry(
        title = state.value.title,
        start = state.value.start ?: return@launch,
        end = state.value.end ?: return@launch,
      )
      planService.updateDayEntry(dayEntryId, planId, newDayEntry)
      _state.emit(state.value.copy(created = true))
    }
  }
}
