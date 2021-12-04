package pl.planik.domain

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.emptyFlow
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.flow.single
import kotlinx.coroutines.flow.take
import kotlinx.coroutines.test.runBlockingTest
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Rule
import org.junit.Test
import org.mockito.kotlin.mock
import org.mockito.kotlin.whenever
import pl.planik.MainCoroutineScopeRule
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.domain.service.PlanService
import pl.planik.domain.source.PlanLocalSource
import pl.planik.domain.source.UserLocalSource
import java.time.OffsetDateTime
import java.time.ZoneOffset

@ExperimentalCoroutinesApi
class PlanServiceTest {

  @get:Rule
  val instantTaskExecutorRule = InstantTaskExecutorRule()

  @get:Rule
  val coroutineScope = MainCoroutineScopeRule()

  private val userLocalSourceMock: UserLocalSource = mock()
  private val planLocalSourceMock: PlanLocalSource = mock()

  private val planService = PlanService(
    userLocalSource = userLocalSourceMock,
    planLocalSource = planLocalSourceMock,
  )

  @Test
  fun should_returnCurrentPlan_When_ThereIsOne() {
    coroutineScope.runBlockingTest {
      val planId = 1
      val userId = 1
      val planName = "Plan"
      val expectedPlan = createPlan(planId, planName)
      whenever(userLocalSourceMock.currentUserId()).thenAnswer { userId }
      whenever(planLocalSourceMock.observeCurrentPlan(userId = userId)).thenAnswer {
        flowOf(
          expectedPlan
        )
      }

      val plan = planService.observeCurrentPlan().take(1).single()
      assertThat(plan, equalTo(expectedPlan))
    }
  }

  @Test
  fun should_returnCurrentPlanEmptyFlow_When_ThereIsNoPlan() {
    coroutineScope.runBlockingTest {
      val userId = 1
      whenever(userLocalSourceMock.currentUserId()).thenAnswer { userId }
      whenever(planLocalSourceMock.observeCurrentPlan(userId)).thenAnswer { emptyFlow<Plan>() }
      val plan = planService.observeCurrentPlan()
      assertThat(plan, equalTo(emptyFlow()))
    }
  }

  @Test
  fun should_returnCurrentPlanEmptyFlow_When_ThereIsNoUser() {
    coroutineScope.runBlockingTest {
      whenever(userLocalSourceMock.currentUserId()).thenAnswer { null }
      val plan = planService.observeCurrentPlan()
      assertThat(plan, equalTo(emptyFlow()))
    }
  }

  @Test
  fun should_addPlan_When_NameWasProvided() {
    coroutineScope.runBlockingTest {
      val planId = 4
      val userId = 2
      val planName = "Planik"
      val expectedPlan = createPlan(planId, planName)
      val newPlan = NewPlan(name = planName)

      whenever(userLocalSourceMock.currentUserId()).thenAnswer { userId }
      whenever(planLocalSourceMock.createPlan(userId, newPlan)).thenAnswer { planId }
      whenever(planLocalSourceMock.getPlan(planId, userId)).thenAnswer { expectedPlan }
      val plan = planService.addPlan(newPlan)
      assertThat(plan, equalTo(expectedPlan))
    }
  }

  @Test
  fun should_deletePlan_When_IdWasProvided() {
    coroutineScope.runBlockingTest {
      val planId = 4
      val userId = 2
      val planName = "Planik"
      val expectedPlan = createPlan(planId, planName)

      whenever(userLocalSourceMock.currentUserId()).thenAnswer { userId }
      whenever(planLocalSourceMock.deletePlan(planId)).thenAnswer { }
      whenever(planLocalSourceMock.getPlan(planId, userId)).thenAnswer { expectedPlan }

      val plan = planService.deletePlan(planId)
      assertThat(plan, equalTo(expectedPlan))
    }
  }

  private fun createPlan(planId: Int, planName: String) = Plan(
    id = planId,
    name = planName,
    current = true,
    createdAt = OffsetDateTime.of(1990, 1, 1, 0, 0, 0, 0, ZoneOffset.UTC),
    days = emptyList()
  )
}
