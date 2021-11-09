package pl.planik.domain.source

import pl.planik.domain.model.NewUser
import pl.planik.domain.model.User

interface UserLocalSource {
  fun hasUser(): Boolean
  suspend fun getUser(): User?
  suspend fun createUser(newUser: NewUser): User?
}