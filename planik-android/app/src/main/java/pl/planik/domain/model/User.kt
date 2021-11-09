package pl.planik.domain.model

import java.time.OffsetDateTime
import java.util.UUID

data class User(
  val id: Int,
  val uuid: UUID,
  val nickname: String,
  val createdAt: OffsetDateTime? = null,
  val updatedAt: OffsetDateTime? = null
)