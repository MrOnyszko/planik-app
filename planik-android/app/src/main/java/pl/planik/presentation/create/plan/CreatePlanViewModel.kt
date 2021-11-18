package pl.planik.presentation.create.plan

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import pl.planik.app.hilt.DefaultCoroutineDispatcher
import pl.planik.domain.service.PlanService
import javax.inject.Inject

@HiltViewModel
class CreatePlanViewModel @Inject constructor(
  @DefaultCoroutineDispatcher private val dispatcher: CoroutineDispatcher,
  private val planService: PlanService,
) : ViewModel() {

  private val pendingActions = MutableSharedFlow<CreatePlanAction>()
  private val _state = MutableStateFlow(CreatePlanState())

  val state: StateFlow<CreatePlanState> = _state.stateIn(
    scope = viewModelScope,
    started = SharingStarted.WhileSubscribed(5000),
    initialValue = CreatePlanState(),
  )

  init {
    viewModelScope.launch(dispatcher) {
      pendingActions.collect { action ->
        when (action) {
          is CreatePlanAction.PlanNameTextChanges -> {
            viewModelScope.launch(dispatcher) {
              _state.emit(state.value.copy(name = action.text))
            }
          }
        }
      }
    }
  }

  fun submitAction(action: CreatePlanAction) {
    viewModelScope.launch(dispatcher) {
      pendingActions.emit(action)
    }
  }
}
