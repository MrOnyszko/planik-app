package pl.planik.domain.service

import pl.planik.domain.model.NewUser
import pl.planik.domain.model.User
import pl.planik.domain.source.UserLocalSource
import javax.inject.Inject

class UserService @Inject constructor(
  private val userLocalSource: UserLocalSource
) {

  fun hasUser(): Boolean = userLocalSource.hasUser()

  suspend fun getCurrentUser(): User? = userLocalSource.getUser()

  suspend fun createUser(nickname: String): User? {
    return userLocalSource.createUser(newUser = NewUser(nickname = nickname))
  }
}