package pl.planik.domain.model

import java.util.UUID

data class NewUser(
  val nickname: String,
  val uuid: UUID = UUID.nameUUIDFromBytes(nickname.toByteArray()),
)