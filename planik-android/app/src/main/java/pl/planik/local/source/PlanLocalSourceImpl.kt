package pl.planik.local.source

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.emptyFlow
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.domain.source.PlanLocalSource
import pl.planik.local.dao.PlansDao
import javax.inject.Inject

class PlanLocalSourceImpl @Inject constructor(
  private val plansDao: PlansDao,
) : PlanLocalSource {

  override suspend fun hasPlan(): Boolean = plansDao.count() > 0

  override fun getCurrentPlan(userId: Int): Flow<Plan> {
    return emptyFlow()
  }

  override suspend fun getPlan(id: Int, userId: Int): Plan? {
    return null
  }

  override suspend fun createPlan(newPlan: NewPlan): Int {
    return -1
  }

  override suspend fun deletePlan(id: Int) {

  }
}