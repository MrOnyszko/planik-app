package pl.planik.local.entity

import androidx.room.*
import java.time.OffsetDateTime
import java.time.ZoneId

@Entity(
  tableName = "plans",
  foreignKeys = [
    ForeignKey(
      entity = UserEntity::class,
      parentColumns = ["id"],
      childColumns = ["user_id"],
      onDelete = ForeignKey.CASCADE,
      onUpdate = ForeignKey.CASCADE
    )
  ],
  indices = [
    Index(value = ["user_id"])
  ]
)
data class PlanEntity(
  @ColumnInfo(name = "id") @PrimaryKey(autoGenerate = true) val id: Int = -1,
  @ColumnInfo(name = "user_id") val userId: Int,
  @ColumnInfo(name = "name") val name: String,
  @ColumnInfo(name = "current") val current: Boolean,
  @ColumnInfo(name = "created_at") val createdAt: OffsetDateTime? = OffsetDateTime.now(ZoneId.of("UTC")),
  @ColumnInfo(name = "updated_at") val updatedAt: OffsetDateTime? = null
)