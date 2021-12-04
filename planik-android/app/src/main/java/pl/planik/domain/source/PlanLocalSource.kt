package pl.planik.domain.source

import androidx.paging.PagingData
import kotlinx.coroutines.flow.Flow
import pl.planik.domain.model.DayEntry
import pl.planik.domain.model.NewDayEntry
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.domain.model.UpdateDayEntry

interface PlanLocalSource {
  suspend fun hasPlan(): Boolean
  fun observeCurrentPlan(userId: Int): Flow<Plan?>
  fun observePlan(id: Int, currentUserId: Int): Flow<Plan?>
  suspend fun getPlan(id: Int, userId: Int): Plan?
  fun pagedPlans(pageSize: Int): Flow<PagingData<Plan>>
  suspend fun createPlan(userId: Int, newPlan: NewPlan): Int
  suspend fun updatePlan(plan: Plan): Int?
  suspend fun deletePlan(id: Int)
  suspend fun getDayEntry(dayEntryId: Int, planId: Int): DayEntry?
  suspend fun addDayEntry(planId: Int, newDayEntry: NewDayEntry): Int
  suspend fun updateDayEntry(
    dayEntryId: Int,
    planId: Int,
    dayEntry: UpdateDayEntry
  ): Int?
}
