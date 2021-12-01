package pl.planik.app

import android.content.Context
import android.text.format.DateFormat
import android.text.format.DateUtils
import dagger.hilt.android.qualifiers.ApplicationContext
import pl.planik.app.hilt.FormatShortTime
import pl.planik.app.hilt.MediumDate
import pl.planik.app.hilt.MediumDateTime
import pl.planik.app.hilt.ShortDate
import pl.planik.app.hilt.ShortTime
import java.time.LocalTime
import java.time.OffsetDateTime
import java.time.OffsetTime
import java.time.format.DateTimeFormatter
import java.time.temporal.Temporal
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class DateFormatter @Inject constructor(
  @ApplicationContext private val context: Context,
  @ShortTime private val shortTimeFormatter: DateTimeFormatter,
  @ShortDate private val shortDateFormatter: DateTimeFormatter,
  @MediumDate private val mediumDateFormatter: DateTimeFormatter,
  @MediumDateTime private val mediumDateTimeFormatter: DateTimeFormatter,
  @FormatShortTime private val formatShortTime: DateTimeFormatter
) {

  fun is24hClock(): Boolean = DateFormat.is24HourFormat(context)

  fun formatShortDate(temporalAmount: Temporal): String =
    shortDateFormatter.format(temporalAmount)

  fun formatMediumDate(temporalAmount: Temporal): String =
    mediumDateFormatter.format(temporalAmount)

  fun formatMediumDateTime(temporalAmount: Temporal): String =
    mediumDateTimeFormatter.format(temporalAmount)

  fun formatShortTime(offsetTime: OffsetTime): String = shortTimeFormatter.format(offsetTime)

  fun formatShortTime(localTime: LocalTime): String = shortTimeFormatter.format(localTime)

  fun formatDayName(temporalAmount: Temporal): String = formatShortTime.format(temporalAmount)

  fun formatShortRelativeTime(dateTime: OffsetDateTime): String {
    val now = OffsetDateTime.now()

    return if (dateTime.isBefore(now)) {
      if (dateTime.year == now.year || dateTime.isAfter(now.minusDays(7))) {
        // Within the past week
        DateUtils.getRelativeTimeSpanString(
          dateTime.toInstant().toEpochMilli(),
          System.currentTimeMillis(),
          DateUtils.MINUTE_IN_MILLIS,
          DateUtils.FORMAT_SHOW_DATE
        ).toString()
      } else {
        // More than 7 days ago
        formatShortDate(dateTime)
      }
    } else {
      if (dateTime.year == now.year || dateTime.isBefore(now.plusDays(14))) {
        // In the near future (next 2 weeks)
        DateUtils.getRelativeTimeSpanString(
          dateTime.toInstant().toEpochMilli(),
          System.currentTimeMillis(),
          DateUtils.MINUTE_IN_MILLIS,
          DateUtils.FORMAT_SHOW_DATE
        ).toString()
      } else {
        // In the far future
        formatShortDate(dateTime)
      }
    }
  }
}