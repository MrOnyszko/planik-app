package pl.planik.local.mapper.to.model

import pl.planik.domain.model.Day
import pl.planik.domain.model.DayEntry
import pl.planik.domain.model.Plan
import pl.planik.foundation.DateProvider
import pl.planik.local.entity.PlanDayEntryEntity
import pl.planik.local.entity.PlanWithDayEntries
import pl.planik.local.mapper.Mapper
import java.time.DayOfWeek
import java.time.Duration
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class PlanWithDayEntriesToModelMapper @Inject constructor(
  private val dateProvider: DateProvider
) : Mapper<PlanWithDayEntries, Plan> {
  override fun map(value: PlanWithDayEntries): Plan {
    val plan = value.plan
      ?: throw IllegalStateException("Plan cannot be null")
    val dayEntries = value.planDayEntries
      ?: throw IllegalStateException("Plan day entries cannot be null")
    val createdAt = plan.createdAt
      ?: throw IllegalStateException("Plan created at cannot be null")

    val now = dateProvider.offsetDateTimeNow()
    val days = dayEntries.groupBy { it.dayOfWeek }
      .map { (dayOfWeek, entries) ->
        val startOfWeek = now.minusDays(now.dayOfWeek.value.toLong())
        val date = startOfWeek.plusDays(dayOfWeek.toLong())
        Day(
          ordinal = dayOfWeek,
          dayOfWeek = DayOfWeek.of(dayOfWeek),
          date = date,
          entries = entries.mapIndexed { index, entry ->
            DayEntry(
              id = entry.id,
              ordinal = index,
              title = entry.title,
              start = entry.start,
              end = entry.end,
              pauseMinutes = calculatePause(index, entries).toMinutes().toInt()
            )
          }
        )
      }

    return Plan(
      id = plan.id,
      name = plan.name,
      current = plan.current,
      createdAt = createdAt,
      days = days
    )
  }

  private fun calculatePause(index: Int, entries: List<PlanDayEntryEntity>): Duration {
    if (index > entries.size || entries.isEmpty() || index < 0 || entries.size == 1) {
      return Duration.ZERO
    }
    val oneAfter = entries[(index + 1).rem(entries.size)]
    return Duration.between(oneAfter.start, entries[index].end)
  }
}