package pl.planik.local.converters

import androidx.room.TypeConverter
import java.util.UUID

internal object UuidConverter {

  @TypeConverter
  @JvmStatic
  fun fromStringToUuid(value: String): UUID = UUID.fromString(value)

  @TypeConverter
  @JvmStatic
  fun fromUuidToString(value: UUID) = value.toString()
}