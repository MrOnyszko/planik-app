package pl.planik.domain.source

import androidx.paging.PagingData
import kotlinx.coroutines.flow.Flow
import pl.planik.domain.model.NewDayEntry
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan

interface PlanLocalSource {
  suspend fun hasPlan(): Boolean
  fun getCurrentPlan(userId: Int): Flow<Plan?>
  suspend fun getPlan(id: Int, userId: Int): Plan?
  fun pagedPlans(pageSize: Int): Flow<PagingData<Plan>>
  suspend fun createPlan(userId: Int, newPlan: NewPlan): Int
  suspend fun updatePlan(plan: Plan): Int?
  suspend fun deletePlan(id: Int)
  suspend fun addDayEntry(planId: Int, newDayEntry: NewDayEntry): Int
}