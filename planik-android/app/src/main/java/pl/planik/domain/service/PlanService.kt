package pl.planik.domain.service

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flowOf
import pl.planik.domain.model.Day
import pl.planik.domain.model.DayEntry
import pl.planik.domain.model.Plan
import pl.planik.domain.source.UserLocalSource
import java.time.DayOfWeek
import java.time.OffsetDateTime
import java.time.ZoneOffset
import javax.inject.Inject

class PlanService @Inject constructor(
  private val userLocalSource: UserLocalSource
) {
  fun getCurrentPlan(): Flow<Plan> {
    return flowOf(
      Plan(
        id = 0,
        name = "November Plan",
        current = true,
        archived = false,
        createdAt = OffsetDateTime.of(2021, 11, 14, 0, 0, 0, 0, ZoneOffset.UTC),
        days = listOf(
          Day(
            ordinal = 0,
            dayOfWeek = DayOfWeek.MONDAY,
            date = OffsetDateTime.of(2021, 11, 15, 0, 0, 0, 0, ZoneOffset.UTC),
            entries = (0..5).map {
              DayEntry(
                id = 1,
                ordinal = it + 1,
                title = "MONDAY $it",
                start = OffsetDateTime.of(2021, 11, 15, 8, 45, 0, 0, ZoneOffset.UTC),
                end = OffsetDateTime.of(2021, 11, 15, 9, 35, 0, 0, ZoneOffset.UTC),
                pauseMinutes = 15
              )
            }
          ),
          Day(
            ordinal = 0,
            dayOfWeek = DayOfWeek.TUESDAY,
            date = OffsetDateTime.of(2021, 11, 16, 0, 0, 0, 0, ZoneOffset.UTC),
            entries = (0..5).map {
              DayEntry(
                id = 1,
                ordinal = it + 1,
                title = "TUESDAY $it",
                start = OffsetDateTime.of(2021, 11, 16, 8, 45, 0, 0, ZoneOffset.UTC),
                end = OffsetDateTime.of(2021, 11, 16, 9, 35, 0, 0, ZoneOffset.UTC),
                pauseMinutes = 15
              )
            }
          ),
          Day(
            ordinal = 0,
            dayOfWeek = DayOfWeek.WEDNESDAY,
            date = OffsetDateTime.of(2021, 11, 17, 0, 0, 0, 0, ZoneOffset.UTC),
            entries = (0..5).map {
              DayEntry(
                id = 1,
                ordinal = it + 1,
                title = "WEDNESDAY $it",
                start = OffsetDateTime.of(2021, 11, 17, 8, 45, 0, 0, ZoneOffset.UTC),
                end = OffsetDateTime.of(2021, 11, 17, 9, 35, 0, 0, ZoneOffset.UTC),
                pauseMinutes = 15
              )
            }
          ),
          Day(
            ordinal = 0,
            dayOfWeek = DayOfWeek.THURSDAY,
            date = OffsetDateTime.of(2021, 11, 18, 0, 0, 0, 0, ZoneOffset.UTC),
            entries = (0..5).map {
              DayEntry(
                id = 1,
                ordinal = it + 1,
                title = "THURSDAY $it",
                start = OffsetDateTime.of(2021, 11, 18, 8, 45, 0, 0, ZoneOffset.UTC),
                end = OffsetDateTime.of(2021, 11, 18, 9, 35, 0, 0, ZoneOffset.UTC),
                pauseMinutes = 15
              )
            }
          ),
          Day(
            ordinal = 0,
            dayOfWeek = DayOfWeek.FRIDAY,
            date = OffsetDateTime.of(2021, 11, 19, 0, 0, 0, 0, ZoneOffset.UTC),
            entries = (0..5).map {
              DayEntry(
                id = 1,
                ordinal = it + 1,
                title = "FRIDAY $it",
                start = OffsetDateTime.of(2021, 11, 19, 8, 45, 0, 0, ZoneOffset.UTC),
                end = OffsetDateTime.of(2021, 11, 19, 9, 35, 0, 0, ZoneOffset.UTC),
                pauseMinutes = 15
              )
            }
          ),
          Day(
            ordinal = 0,
            dayOfWeek = DayOfWeek.SATURDAY,
            date = OffsetDateTime.of(2021, 11, 20, 0, 0, 0, 0, ZoneOffset.UTC),
            entries = listOf()
          ),
          Day(
            ordinal = 0,
            dayOfWeek = DayOfWeek.SUNDAY,
            date = OffsetDateTime.of(2021, 11, 21, 0, 0, 0, 0, ZoneOffset.UTC),
            entries = listOf()
          )
        )
      )
    )
  }
}