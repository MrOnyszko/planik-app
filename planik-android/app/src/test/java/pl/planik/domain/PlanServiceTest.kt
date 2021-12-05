@file:Suppress("SameParameterValue")

package pl.planik.domain

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.paging.PagingData
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
import pl.planik.domain.model.DayEntry
import pl.planik.domain.model.NewDayEntry
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.domain.model.UpdateDayEntry
import pl.planik.domain.service.PlanService
import pl.planik.domain.source.PlanLocalSource
import pl.planik.domain.source.UserLocalSource
import java.time.DayOfWeek
import java.time.OffsetDateTime
import java.time.OffsetTime
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
  fun should_returnPlan_When_ThereIsOne() {
    coroutineScope.runBlockingTest {
      val planId = 2
      val userId = 2
      val planName = "2022"
      val expectedPlan = createPlan(planId, planName)
      whenever(userLocalSourceMock.currentUserId()).thenAnswer { userId }
      whenever(planLocalSourceMock.observePlan(planId, userId)).thenAnswer {
        flowOf(expectedPlan)
      }

      val plan = planService.observePlan(planId).take(1).single()
      assertThat(plan, equalTo(expectedPlan))
    }
  }

  @Test
  fun should_returnPlanEmptyFlow_When_ThereIsNoPlan() {
    coroutineScope.runBlockingTest {
      val planId = 1
      val userId = 1
      whenever(userLocalSourceMock.currentUserId()).thenAnswer { userId }
      whenever(planLocalSourceMock.observePlan(planId, userId)).thenAnswer { emptyFlow<Plan>() }
      val plan = planService.observePlan(planId)
      assertThat(plan, equalTo(emptyFlow()))
    }
  }

  @Test
  fun should_returnPagedPlans_When_ThereArePlans() {
    coroutineScope.runBlockingTest {
      val pageSize = 5
      val planName = "202"
      val expectedPlans = (0..5).map { createPlan(it, planName.plus(it)) }
      val expectedPagingData = PagingData.from(expectedPlans)
      whenever(planLocalSourceMock.pagedPlans(pageSize)).thenAnswer {
        flowOf(expectedPagingData)
      }

      val plan = planService.pagedPlans(pageSize).take(1).single()
      assertThat(plan, equalTo(expectedPagingData))
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
  fun should_updatePlan_When_PlanIsProvided() {
    coroutineScope.runBlockingTest {
      val planId = 4
      val userId = 2
      val plan = createPlan(planId, "Planik")
      val expectedPlan = plan.copy(name = "Planik 2020")

      whenever(userLocalSourceMock.currentUserId()).thenAnswer { userId }
      whenever(planLocalSourceMock.updatePlan(plan)).thenAnswer { planId }
      whenever(planLocalSourceMock.getPlan(planId, userId)).thenAnswer { expectedPlan }
      val updatedPlan = planService.updatePlan(plan)
      assertThat(updatedPlan, equalTo(expectedPlan))
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

  @Test
  fun should_returnHasPlanTrue_When_AtLeastOnePlanWasCreated() {
    coroutineScope.runBlockingTest {
      whenever(planLocalSourceMock.hasPlan()).thenReturn(true)

      val hasUser = planService.hasPlan()
      assert(hasUser)
    }
  }

  @Test
  fun should_returnHasPlanFalse_When_AtLeastOnePlanWasNotCreated() {
    coroutineScope.runBlockingTest {
      whenever(planLocalSourceMock.hasPlan()).thenReturn(false)

      val hasUser = planService.hasPlan()
      assert(!hasUser)
    }
  }

  @Test
  fun should_getDayEntry_When_ThereIsOne() {
    coroutineScope.runBlockingTest {
      val dayEntryId = 3
      val planId = 2
      val expectedDayEntry = createDayEntry(dayEntryId, planId, "Planik")
      whenever(planLocalSourceMock.getDayEntry(dayEntryId, planId)).thenAnswer { expectedDayEntry }

      val dayEntry = planService.getDayEntry(dayEntryId, planId)
      assertThat(dayEntry, equalTo(expectedDayEntry))
    }
  }

  @Test
  fun should_addDayEntry_When_NewDayEntryIsProvided() {
    coroutineScope.runBlockingTest {
      val dayEntryId = 2
      val newDayEntry = createNewDayEntry(title = "Math")
      whenever(planLocalSourceMock.addDayEntry(dayEntryId, newDayEntry)).thenAnswer { dayEntryId }

      val dayEntry = planService.addDayEntry(dayEntryId, newDayEntry)
      assertThat(dayEntry, equalTo(dayEntryId))
    }
  }

  @Test
  fun should_updateDayEntry_When_NewDayEntryIsProvided() {
    coroutineScope.runBlockingTest {
      val dayEntryId = 2
      val planId = 2
      val updateDayEntry = createUpdateNewDayEntry(title = "Math")
      whenever(
        planLocalSourceMock.updateDayEntry(dayEntryId, planId, updateDayEntry)
      ).thenAnswer { dayEntryId }

      val dayEntry = planService.updateDayEntry(dayEntryId, planId, updateDayEntry)
      assertThat(dayEntry, equalTo(dayEntryId))
    }
  }

  private fun createPlan(planId: Int, planName: String) = Plan(
    id = planId,
    name = planName,
    current = true,
    createdAt = OffsetDateTime.of(1990, 1, 1, 0, 0, 0, 0, ZoneOffset.UTC),
    days = emptyList()
  )

  private fun createDayEntry(dayEntryId: Int, planId: Int, title: String) = DayEntry(
    id = dayEntryId,
    dayOfWeek = DayOfWeek.MONDAY,
    title = title,
    start = OffsetDateTime.of(2022, 1, 1, 1, 1, 1, 1, ZoneOffset.UTC),
    end = OffsetDateTime.of(2022, 1, 2, 1, 1, 1, 1, ZoneOffset.UTC),
    pauseMinutes = 15,
  )

  private fun createNewDayEntry(title: String) = NewDayEntry(
    dayOfWeek = DayOfWeek.MONDAY,
    title = title,
    start = OffsetTime.of(1, 1, 1, 1, ZoneOffset.UTC),
    end = OffsetTime.of(2, 1, 1, 1, ZoneOffset.UTC),
  )

  private fun createUpdateNewDayEntry(title: String) = UpdateDayEntry(
    title = title,
    start = OffsetTime.of(1, 1, 1, 1, ZoneOffset.UTC),
    end = OffsetTime.of(2, 1, 1, 1, ZoneOffset.UTC),
  )
}
