package pl.planik.local

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import pl.planik.local.converters.DateTimeConverter
import pl.planik.local.converters.UuidConverter
import pl.planik.local.dao.UsersDao
import pl.planik.local.entity.UserEntity

@Database(
  entities = [
    UserEntity::class,
  ],
  version = 1,
  exportSchema = true
)
@TypeConverters(
  value = [
    DateTimeConverter::class,
    UuidConverter::class,
  ]
)
abstract class LocalDatabase : RoomDatabase() {
  abstract fun usersDao(): UsersDao
}