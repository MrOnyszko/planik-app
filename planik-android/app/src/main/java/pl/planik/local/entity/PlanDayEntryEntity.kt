package pl.planik.local.entity

import androidx.room.*
import java.time.OffsetDateTime
import java.time.ZoneId

@Entity(
  tableName = "plan_day_entries",
  foreignKeys = [
    ForeignKey(
      entity = UserEntity::class,
      parentColumns = ["id"],
      childColumns = ["plan_id"],
      onDelete = ForeignKey.CASCADE,
      onUpdate = ForeignKey.CASCADE
    )
  ],
  indices = [
    Index(value = ["plan_id"])
  ]
)
data class PlanDayEntryEntity(
  @ColumnInfo(name = "id") @PrimaryKey(autoGenerate = true) val id: Int = -1,
  @ColumnInfo(name = "plan_id") val planId: Int,
  @ColumnInfo(name = "day_of_week") val dayOfWeek: Int,
  @ColumnInfo(name = "start") val start: OffsetDateTime? = OffsetDateTime.now(ZoneId.of("UTC")),
  @ColumnInfo(name = "end") val end: OffsetDateTime? = null,
  @ColumnInfo(name = "created_at") val createdAt: OffsetDateTime? = OffsetDateTime.now(ZoneId.of("UTC")),
  @ColumnInfo(name = "updated_at") val updatedAt: OffsetDateTime? = null
)