package pl.planik.domain.service

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.emptyFlow
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.domain.source.PlanLocalSource
import pl.planik.domain.source.UserLocalSource
import javax.inject.Inject

class PlanService @Inject constructor(
  private val userLocalSource: UserLocalSource,
  private val planLocalSource: PlanLocalSource,
) {
  suspend fun hasPlan(): Boolean = planLocalSource.hasPlan()

  fun getCurrentPlan(): Flow<Plan?> {
    val currentUserId = userLocalSource.currentUserId() ?: return emptyFlow()
    return planLocalSource.getCurrentPlan(currentUserId)
  }

  suspend fun getPlan(id: Int): Plan? {
    val currentUserId = userLocalSource.currentUserId() ?: return null
    return planLocalSource.getPlan(id, currentUserId)
  }

  suspend fun addPlan(newPlan: NewPlan): Plan? {
    val currentUserId = userLocalSource.currentUserId() ?: return null
    val id = planLocalSource.createPlan(currentUserId, newPlan)
    userLocalSource.setHasPlan(true)
    return getPlan(id)
  }

  suspend fun updatePlan(plan: Plan): Plan? {
    val id = planLocalSource.updatePlan(plan) ?: return null
    return getPlan(id)
  }

  suspend fun deletePlan(id: Int): Plan? {
    val plan = getPlan(id)
    planLocalSource.deletePlan(id)
    return plan
  }
}