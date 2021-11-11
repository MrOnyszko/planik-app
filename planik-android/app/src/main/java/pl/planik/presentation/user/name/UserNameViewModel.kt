package pl.planik.presentation.user.name

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import pl.planik.domain.service.UserService
import javax.inject.Inject

@HiltViewModel
class UserNameViewModel @Inject constructor(
  private val userService: UserService,
) : ViewModel() {

  private val pendingActions = MutableSharedFlow<UserNameAction>()
  private val _state = MutableStateFlow(UserNameState.Empty)

  val state: StateFlow<UserNameState> = _state.stateIn(
    scope = viewModelScope,
    started = SharingStarted.WhileSubscribed(5000),
    initialValue = UserNameState.Empty,
  )

  init {
    viewModelScope.launch {
      pendingActions.collect { action ->
        when (action) {
          UserNameAction.Confirm -> {
            viewModelScope.launch {
              _state.emit(state.value.copy(isLoading = true))
              userService.createUser(state.value.name)
              _state.emit(state.value.copy(isLoading = false, created = true))
            }
          }
          is UserNameAction.NameTextChanges -> {
            viewModelScope.launch {
              _state.emit(state.value.copy(name = action.text))
            }
          }
        }
      }
    }
  }

  fun submitAction(action: UserNameAction) {
    viewModelScope.launch {
      pendingActions.emit(action)
    }
  }
}
