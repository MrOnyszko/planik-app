@file:Suppress("CanBeParameter")

package pl.planik.presentation.plans

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.PagingData
import androidx.paging.cachedIn
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import pl.planik.app.hilt.DefaultCoroutineDispatcher
import pl.planik.domain.model.Plan
import pl.planik.domain.service.PlanService
import pl.planik.presentation.common.StateStatus
import javax.inject.Inject

@HiltViewModel
class PlansViewModel @Inject constructor(
  @DefaultCoroutineDispatcher private val dispatcher: CoroutineDispatcher,
  private val planService: PlanService
) : ViewModel() {

  private val pendingActions = MutableSharedFlow<PlansAction>()
  private val _state = MutableStateFlow(PlansState())

  val state: StateFlow<PlansState> = _state
    .stateIn(
      scope = viewModelScope,
      started = SharingStarted.WhileSubscribed(5000),
      initialValue = PlansState(stateStatus = StateStatus.LOADED),
    )

  val plans: Flow<PagingData<Plan>> by lazy {
    planService.pagedPlans(pageSize = 20).cachedIn(viewModelScope)
  }

  init {
    viewModelScope.launch(dispatcher) {
      pendingActions.collect { }
    }
  }

  fun submitAction(action: PlansAction) {
    viewModelScope.launch(dispatcher) {
      pendingActions.emit(action)
    }
  }
}
