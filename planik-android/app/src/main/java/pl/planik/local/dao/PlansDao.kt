package pl.planik.local.dao

import androidx.paging.PagingSource
import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction
import androidx.room.Update
import kotlinx.coroutines.flow.Flow
import pl.planik.local.entity.PlanDayEntryEntity
import pl.planik.local.entity.PlanEntity
import pl.planik.local.entity.PlanWithDayEntries
import java.time.OffsetDateTime
import java.time.ZoneId

@Dao
interface PlansDao {

  @Query("SELECT COUNT(*) FROM plans")
  suspend fun count(): Int

  @Query("SELECT * FROM plans WHERE id = :id")
  suspend fun queryById(id: Int): PlanEntity?

  @Transaction
  @Query("SELECT * FROM plans WHERE id = :id AND user_id = :userId")
  suspend fun queryOne(id: Int, userId: Int): PlanWithDayEntries?

  @Query("SELECT * FROM plans ORDER BY created_at")
  fun pagedPlans(): PagingSource<Int, PlanEntity>

  @Transaction
  @Query("SELECT * FROM plans WHERE user_id = :userId AND current = 1")
  fun currentPlan(userId: Int): Flow<PlanWithDayEntries?>

  @Query("DELETE FROM plans WHERE id = :id")
  suspend fun deleteById(id: Int): Int

  @Query("SELECT * FROM plan_day_entries WHERE id = :id AND plan_id = :planId")
  suspend fun queryPlanDayEntryEntity(id: Int, planId: Int): PlanDayEntryEntity?

  @Insert(onConflict = OnConflictStrategy.IGNORE)
  suspend fun insertPlanDayEntryEntity(entity: PlanDayEntryEntity): Long

  @Insert(onConflict = OnConflictStrategy.REPLACE)
  suspend fun updatePlanDayEntryEntity(entity: PlanDayEntryEntity): Long

  @Insert(onConflict = OnConflictStrategy.IGNORE)
  suspend fun insertManyPlanDayEntryEntities(entity: List<PlanDayEntryEntity>): List<Long>

  @Insert(onConflict = OnConflictStrategy.IGNORE)
  suspend fun insert(entity: PlanEntity): Long

  @Update(onConflict = OnConflictStrategy.REPLACE)
  suspend fun update(entity: PlanEntity): Int

  @Transaction
  suspend fun upsert(user: PlanEntity) {
    val id = insert(user)
    if (id == -1L) {
      update(user.copy(updatedAt = OffsetDateTime.now(ZoneId.of("UTC"))))
    }
  }

  @Delete
  suspend fun delete(entity: PlanEntity): Int
}