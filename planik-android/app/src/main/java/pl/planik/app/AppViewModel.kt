package pl.planik.app

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import pl.planik.domain.service.UserService
import javax.inject.Inject

@HiltViewModel
class AppViewModel @Inject constructor(
  private val userService: UserService,
) : ViewModel() {

  val hasUser: Boolean
    get() = userService.hasUser()

  val hasPlan: Boolean
    get() = userService.hasPlan()

}
