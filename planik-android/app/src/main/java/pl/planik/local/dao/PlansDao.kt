package pl.planik.local.dao

import androidx.room.*
import pl.planik.local.entity.PlanEntity
import java.time.OffsetDateTime
import java.time.ZoneId

@Dao
interface PlansDao {

  @Query("SELECT * FROM plans WHERE id = :id")
  suspend fun queryById(id: Int): PlanEntity

  @Query("DELETE FROM plans WHERE id = :id")
  suspend fun deleteById(id: Int): Int

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