package pl.planik.local.source

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.domain.source.PlanLocalSource
import pl.planik.foundation.DateProvider
import pl.planik.local.dao.PlansDao
import pl.planik.local.entity.PlanDayEntryEntity
import pl.planik.local.entity.PlanEntity
import pl.planik.local.mapper.to.model.PlanWithDayEntriesToModelMapper
import javax.inject.Inject

class PlanLocalSourceImpl @Inject constructor(
  private val plansDao: PlansDao,
  private val dateProvider: DateProvider,
  private val planWithDayEntriesToModelMapper: PlanWithDayEntriesToModelMapper,
) : PlanLocalSource {

  override suspend fun hasPlan(): Boolean = plansDao.count() > 0

  override fun getCurrentPlan(userId: Int): Flow<Plan> {
    return plansDao.currentPlan(userId).map(planWithDayEntriesToModelMapper::map)
  }

  override suspend fun getPlan(id: Int, userId: Int): Plan? {
    val plan = plansDao.queryOne(id, userId) ?: return null
    return planWithDayEntriesToModelMapper.map(plan)
  }

  override suspend fun createPlan(userId: Int, newPlan: NewPlan): Int {
    val now = dateProvider.offsetDateTimeNow()

    val plan = PlanEntity(
      userId = userId,
      name = newPlan.name,
      current = false,
      createdAt = now
    )

    val planId = plansDao.insert(plan)

    val dayEntries = (1 until 8).map { index ->
      PlanDayEntryEntity(
        planId = planId.toInt(),
        dayOfWeek = index,
        title = "-",
        start = now.withHour(8).withMinute(0),
        end = now.withHour(8).withMinute(45),
      )
    }

    plansDao.insert(dayEntries)

    return planId.toInt()
  }

  override suspend fun deletePlan(id: Int) {
    plansDao.deleteById(id)
  }
}