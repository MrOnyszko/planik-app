package pl.planik.local.mapper.to.entity

import pl.planik.domain.model.NewUser
import pl.planik.local.entity.UserEntity
import pl.planik.local.mapper.Mapper
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class NewUserToEntityMapper @Inject constructor() : Mapper<NewUser, UserEntity> {
  override fun map(value: NewUser): UserEntity {
    return UserEntity(
      uuid = value.uuid,
      nickname = value.nickname,
    )
  }
}
