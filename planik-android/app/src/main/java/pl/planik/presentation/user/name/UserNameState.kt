package pl.planik.presentation.user.name

import androidx.compose.runtime.Immutable

@Immutable
data class UserNameState(
  val name: String,
  val isLoading: Boolean = false,
  val userHasBeenCreated: Boolean = false
) {
  val isConfirmEnabled: Boolean
    get() = name.isNotBlank() && name.length >= 3 && !isLoading

  companion object {
    val Empty = UserNameState(name = "")
  }
}