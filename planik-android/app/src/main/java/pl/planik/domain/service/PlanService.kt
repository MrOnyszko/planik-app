package pl.planik.domain.service

import kotlinx.coroutines.flow.Flow
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.domain.source.PlanLocalSource
import pl.planik.domain.source.UserLocalSource
import javax.inject.Inject

class PlanService @Inject constructor(
  private val userLocalSource: UserLocalSource,
  private val planLocalSource: PlanLocalSource,
) {
  fun getCurrentPlan(): Flow<Plan> = planLocalSource.getCurrentPlan()

  suspend fun getPlan(id: Int): Plan? {
    val currentUserId = userLocalSource.currentUserId() ?: return null
    return planLocalSource.getPlan(id, currentUserId)
  }

  suspend fun addPlan(newPlan: NewPlan): Plan? {
    val id = planLocalSource.createPlan(newPlan)
    return getPlan(id)
  }

  suspend fun deletePlan(id: Int): Plan? {
    val plan = getPlan(id)
    planLocalSource.deletePlan(id)
    return plan
  }
}