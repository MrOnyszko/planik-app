package pl.planik.local.converters

import androidx.room.TypeConverter
import java.time.OffsetDateTime
import java.time.format.DateTimeFormatter

internal object DateTimeConverter {

  private val formatter = DateTimeFormatter.ISO_OFFSET_DATE_TIME

  @TypeConverter
  @JvmStatic
  fun toDateTime(value: String?) = value?.let { formatter.parse(it, OffsetDateTime::from) }

  @TypeConverter
  @JvmStatic
  fun fromDateTime(value: OffsetDateTime?) = value?.format(formatter)
}