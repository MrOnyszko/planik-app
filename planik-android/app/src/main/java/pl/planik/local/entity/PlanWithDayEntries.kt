package pl.planik.local.entity

import androidx.room.Embedded
import androidx.room.Relation

class PlanWithDayEntries {

  @Embedded
  var plan: PlanEntity? = null

  @Relation(
    parentColumn = "id",
    entityColumn = "plan_id",
    entity = PlanDayEntryEntity::class,
  )
  var planDayEntries: List<PlanDayEntryEntity>? = emptyList()
}
