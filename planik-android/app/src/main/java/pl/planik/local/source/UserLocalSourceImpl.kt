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
  override suspend fun getUser(): User? {
    val uuid = usersPreferences.uuid?.uuid() ?: return null
    val entity = usersDao.queryUser(uuid = uuid)
    return userEntityToModelMapper.map(entity)
  }

  override suspend fun createUser(newUser: NewUser): User? {
    usersPreferences.uuid = newUser.uuid.toString()
    usersDao.upsert(newUserToEntityMapper.map(newUser))
    return getUser()
  }
}