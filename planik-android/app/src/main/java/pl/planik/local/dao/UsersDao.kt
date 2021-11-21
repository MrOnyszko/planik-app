package pl.planik.local.dao

import androidx.room.*
import pl.planik.local.entity.UserEntity
import java.time.OffsetDateTime
import java.time.ZoneId
import java.util.*

@Dao
interface UsersDao {

  @Query("SELECT * FROM users WHERE id = :id")
  suspend fun queryUser(id: Int): UserEntity?

  @Query("SELECT * FROM users WHERE uuid = :uuid")
  suspend fun queryUser(uuid: UUID): UserEntity?

  @Insert(onConflict = OnConflictStrategy.IGNORE)
  suspend fun insert(entity: UserEntity): Long

  @Update(onConflict = OnConflictStrategy.REPLACE)
  suspend fun update(entity: UserEntity): Int

  @Transaction
  suspend fun upsert(user: UserEntity): Int {
    val id = insert(user)
    if (id == -1L) {
      update(user.copy(updatedAt = OffsetDateTime.now(ZoneId.of("UTC"))))
    }
    return id.toInt()
  }

  @Delete
  suspend fun delete(entity: UserEntity): Int
}