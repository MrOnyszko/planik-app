package pl.planik.local.source

import pl.planik.domain.model.NewUser
import pl.planik.domain.model.User
import pl.planik.domain.source.UserLocalSource
import pl.planik.local.UserPreferences
import pl.planik.local.dao.UsersDao
import pl.planik.local.mapper.to.entity.NewUserToEntityMapper
import pl.planik.local.mapper.to.model.UserEntityToModelMapper
import pl.planik.local.uuid
import javax.inject.Inject

class UserLocalSourceImpl @Inject constructor(
  private val usersDao: UsersDao,
  private val usersPreferences: UserPreferences,
  private val newUserToEntityMapper: NewUserToEntityMapper,
  private val userEntityToModelMapper: UserEntityToModelMapper,
) : UserLocalSource {

  override fun currentUserId(): Int? = usersPreferences.id.takeIf { it != -1 }

  override fun hasUser(): Boolean = usersPreferences.uuid != null

  override suspend fun getCurrentUser(): User? {
    val uuid = usersPreferences.uuid?.uuid() ?: return null
    val entity = usersDao.queryUser(uuid = uuid)
    return userEntityToModelMapper.map(entity)
  }

  override suspend fun createUser(newUser: NewUser): User? {
    usersPreferences.uuid = newUser.uuid.toString()
    val id = usersDao.upsert(newUserToEntityMapper.map(newUser))
    usersPreferences.id = id
    return getCurrentUser()
  }
}
