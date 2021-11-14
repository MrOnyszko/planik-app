package pl.planik.local.entity

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey
import java.time.OffsetDateTime
import java.time.ZoneId
import java.util.*

@Entity(
  tableName = "users", indices = [
    Index("uuid", unique = true)
  ]
)
data class UserEntity(
  @ColumnInfo(name = "id") @PrimaryKey(autoGenerate = true) val id: Int = -1,
  @ColumnInfo(name = "uuid") val uuid: UUID,
  @ColumnInfo(name = "nickname") val nickname: String,
  @ColumnInfo(name = "email") val email: String? = null,
  @ColumnInfo(name = "created_at") val createdAt: OffsetDateTime? = OffsetDateTime.now(ZoneId.of("UTC")),
  @ColumnInfo(name = "updated_at") val updatedAt: OffsetDateTime? = null
)