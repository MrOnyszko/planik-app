package pl.planik.domain.source

import pl.planik.domain.model.NewUser
import pl.planik.domain.model.User

interface UserLocalSource {
  fun currentUserId(): Int?
  fun hasUser(): Boolean
  fun hasPlan(): Boolean
  fun setHasPlan(value: Boolean)
  suspend fun getCurrentUser(): User?
  suspend fun createUser(newUser: NewUser): User?
}