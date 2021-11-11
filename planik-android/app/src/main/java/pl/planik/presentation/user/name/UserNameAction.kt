package pl.planik.presentation.user.name

sealed class UserNameAction {
  object Confirm : UserNameAction()
  data class NameTextChanges(val text: String = "") : UserNameAction()
}