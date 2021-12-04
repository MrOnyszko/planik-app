package pl.planik.local.source

import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import androidx.paging.map
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import pl.planik.domain.model.DayEntry
import pl.planik.domain.model.NewDayEntry
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.domain.model.UpdateDayEntry
import pl.planik.domain.source.PlanLocalSource
import pl.planik.foundation.DateProvider
import pl.planik.local.dao.PlansDao
import pl.planik.local.entity.PlanDayEntryEntity
import pl.planik.local.entity.PlanEntity
import pl.planik.local.mapper.to.model.PlanDayEntryEntityToModelMapper
import pl.planik.local.mapper.to.model.PlanWithDayEntriesToModelMapper
import java.time.ZoneId
import javax.inject.Inject

class PlanLocalSourceImpl @Inject constructor(
  private val plansDao: PlansDao,
  private val dateProvider: DateProvider,
  private val planWithDayEntriesToModelMapper: PlanWithDayEntriesToModelMapper,
  private val planDayEntryEntityToModelMapper: PlanDayEntryEntityToModelMapper,
) : PlanLocalSource {

  override suspend fun hasPlan(): Boolean = plansDao.count() > 0

  override fun getCurrentPlan(userId: Int): Flow<Plan?> {
    return plansDao.currentPlan(userId).map { entity ->
      entity?.let { planWithDayEntriesToModelMapper.map(it) }
    }
  }

  override suspend fun getPlan(id: Int, userId: Int): Plan? {
    val plan = plansDao.queryOne(id, userId) ?: return null
    return planWithDayEntriesToModelMapper.map(plan)
  }

  override fun pagedPlans(pageSize: Int): Flow<PagingData<Plan>> {
    return Pager(PagingConfig(pageSize = 20)) {
      plansDao.pagedPlans()
    }.flow.map { pagingData ->
      pagingData.map { entity ->
        Plan(
          id = entity.id,
          name = entity.name,
          current = entity.current,
          createdAt = entity.createdAt!!,
          days = emptyList()
        )
      }
    }
  }

  override suspend fun createPlan(userId: Int, newPlan: NewPlan): Int {
    val now = dateProvider.offsetDateTimeNow()

    val plan = PlanEntity(
      userId = userId,
      name = newPlan.name,
      current = newPlan.current,
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

    plansDao.insertManyPlanDayEntryEntities(dayEntries)

    return planId.toInt()
  }

  override suspend fun updatePlan(plan: Plan): Int? {
    val entity = plansDao.queryById(plan.id)
    if (entity != null) {
      val entityToUpdate = entity.copy(
        name = plan.name,
        current = plan.current,
        updatedAt = dateProvider.offsetDateTimeNow(ZoneId.of("UTC")),
      ).apply { id = entity.id }
      return plansDao.update(entityToUpdate)
    }
    return null
  }

  override suspend fun deletePlan(id: Int) {
    plansDao.deleteById(id)
  }

  override suspend fun getDayEntry(dayEntryId: Int, planId: Int): DayEntry? {
    val entity = plansDao.queryPlanDayEntryEntity(dayEntryId, planId) ?: return null
    return planDayEntryEntityToModelMapper.map(entity)
  }

  override suspend fun addDayEntry(planId: Int, newDayEntry: NewDayEntry): Int {
    val now = dateProvider.offsetDateTimeNow()
    val dayEntry = PlanDayEntryEntity(
      planId = planId,
      dayOfWeek = newDayEntry.dayOfWeek.value,
      title = newDayEntry.title,
      start = now.withHour(newDayEntry.start.hour).withMinute(newDayEntry.start.minute),
      end = now.withHour(newDayEntry.end.hour).withMinute(newDayEntry.end.minute),
    )
    return plansDao.insertPlanDayEntryEntity(dayEntry).toInt()
  }

  override suspend fun updateDayEntry(
    dayEntryId: Int,
    planId: Int,
    dayEntry: UpdateDayEntry
  ): Int? {
    val now = dateProvider.offsetDateTimeNow()
    val existing = plansDao.queryPlanDayEntryEntity(dayEntryId, planId) ?: return null
    val entity = existing.copy(
      title = dayEntry.title,
      start = now.withHour(dayEntry.start.hour).withMinute(dayEntry.start.minute),
      end = now.withHour(dayEntry.end.hour).withMinute(dayEntry.end.minute),
    ).apply { id = dayEntryId }
    return plansDao.updatePlanDayEntryEntity(entity).toInt()
  }
}