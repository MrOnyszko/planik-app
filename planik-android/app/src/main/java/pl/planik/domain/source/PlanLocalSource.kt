package pl.planik.domain.source

import kotlinx.coroutines.flow.Flow
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan

interface PlanLocalSource {
  suspend fun hasPlan(): Boolean
  fun getCurrentPlan(): Flow<Plan>
  suspend fun getPlan(id: Int, userId: Int): Plan?
  suspend fun createPlan(newPlan: NewPlan): Int
  suspend fun deletePlan(id: Int)
}