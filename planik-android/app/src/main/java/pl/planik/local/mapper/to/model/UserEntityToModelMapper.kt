package pl.planik.local.mapper.to.model

import pl.planik.domain.model.User
import pl.planik.local.entity.UserEntity
import pl.planik.local.mapper.Mapper
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class UserEntityToModelMapper @Inject constructor() : Mapper<UserEntity, User> {
  override fun map(value: UserEntity): User = User(
    id = value.id,
    uuid = value.uuid,
    nickname = value.nickname,
    createdAt = value.createdAt,
    updatedAt = value.updatedAt
  )
}