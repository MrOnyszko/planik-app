package pl.planik.local

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.test.TestCoroutineDispatcher
import kotlinx.coroutines.test.runBlockingTest
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.kotlin.mock
import org.mockito.kotlin.whenever
import pl.planik.MainCoroutineScopeRule
import pl.planik.domain.model.Day
import pl.planik.domain.model.DayEntry
import pl.planik.domain.model.NewPlan
import pl.planik.domain.model.Plan
import pl.planik.foundation.DateProvider
import pl.planik.local.dao.PlansDao
import pl.planik.local.entity.PlanDayEntryEntity
import pl.planik.local.entity.PlanEntity
import pl.planik.local.entity.PlanWithDayEntries
import pl.planik.local.mapper.to.model.PlanWithDayEntriesToModelMapper
import pl.planik.local.source.PlanLocalSourceImpl
import java.time.DayOfWeek
import java.time.OffsetDateTime
import java.time.ZoneOffset

@ExperimentalCoroutinesApi
class PlanLocalSourceTest {

  private val testDispatcher = TestCoroutineDispatcher()

  @get:Rule
  val instantTaskExecutorRule = InstantTaskExecutorRule()

  @get:Rule
  val coroutineScope = MainCoroutineScopeRule()

  private val plansDaoMock: PlansDao = mock()
  private val dateProviderMock: DateProvider = mock()

  private val planWithDayEntriesToModelMapper = PlanWithDayEntriesToModelMapper(
    dateProvider = dateProviderMock
  )

  private val userLocalSource = PlanLocalSourceImpl(
    plansDao = plansDaoMock,
    dateProvider = dateProviderMock,
    planWithDayEntriesToModelMapper = planWithDayEntriesToModelMapper,
  )

  private val now = OffsetDateTime.of(2021, 11, 15, 10, 0, 0, 0, ZoneOffset.UTC)

  @Before
  fun setUp() {
    whenever(dateProviderMock.offsetDateTimeNow()).thenReturn(now)
  }

  @Test
  fun should_returnHasPlanTrue_When_ThereIsAtLeastOnePlan() {
    coroutineScope.runBlockingTest {
      whenever(plansDaoMock.count()).thenAnswer { 8 }
      val hasPlan = userLocalSource.hasPlan()
      assertThat(hasPlan, equalTo(true))
    }
  }

  @Test
  fun should_returnHasPlanFalse_When_ThereIsNoPlans() {
    coroutineScope.runBlockingTest {
      whenever(plansDaoMock.count()).thenAnswer { 0 }
      val hasPlan = userLocalSource.hasPlan()
      assertThat(hasPlan, equalTo(false))
    }
  }

  @Test
  fun should_returnCurrentPlanFlow_When_ThereIsCurrentPlan() {
    coroutineScope.runBlockingTest {
      val userId = 3
      val planWithDayEntries = createPlanWithEntriesEntity(id = 2, userId = userId, name = "xyz")
      val expectPlan = createPlan(id = 2, name = "xyz")
      whenever(plansDaoMock.currentPlan(userId)).thenAnswer { flowOf(planWithDayEntries) }
      val plan = userLocalSource.getCurrentPlan(userId).take(1).single()
      assertThat(plan.id, equalTo(expectPlan.id))
      assertThat(plan.name, equalTo(expectPlan.name))
      assertThat(plan.days[0].ordinal, equalTo(expectPlan.days[0].ordinal))
      assertThat(plan.days[5].dayOfWeek, equalTo(expectPlan.days[5].dayOfWeek))
      assertThat(plan.days[5].entries[0].id, equalTo(expectPlan.days[5].entries[0].id))
      assertThat(plan.days[5].entries[0].start, equalTo(expectPlan.days[5].entries[0].start))
      assertThat(plan.days[5].entries[0].end, equalTo(expectPlan.days[5].entries[0].end))
    }
  }

  @Test
  fun should_returnCurrentPlanEmptyFlow_When_ThereIsNoCurrentPlan() {
    coroutineScope.runBlockingTest {
      val userId = 1
      whenever(plansDaoMock.currentPlan(userId)).thenAnswer { emptyFlow<PlanWithDayEntries>() }
      val plan = userLocalSource.getCurrentPlan(userId).take(1).singleOrNull()
      assertThat(plan, equalTo(null))
    }
  }

  @Test
  fun should_createNewPlan_When_DataIsProvided() {
    coroutineScope.runBlockingTest {
      val userId = 1
      val newPlan = NewPlan(name = "Planner")
      val planWithDayEntries = createPlanWithEntriesEntity(
        id = 1,
        userId = userId,
        name = "Planner"
      )

      val planEntity = planWithDayEntries.plan!!.copy(id = -1)
      val planDayEntries = planWithDayEntries.planDayEntries!!

      whenever(plansDaoMock.insert(planEntity)).thenAnswer { 1L }
      whenever(plansDaoMock.insert(planDayEntries)).thenAnswer {
        (1 until 8).map { it }.toList()
      }

      val id = userLocalSource.createPlan(userId, newPlan)
      assertThat(id, equalTo(1))
    }
  }

  @Test
  fun should_deletePlan_When_PlanIdIsProvided() {
    coroutineScope.runBlockingTest {
      whenever(plansDaoMock.deleteById(1)).thenAnswer { 1 }
      userLocalSource.deletePlan(1)
    }
  }

  private fun createPlanWithEntriesEntity(id: Int, userId: Int, name: String): PlanWithDayEntries {
    val createdAt = OffsetDateTime.of(2021, 11, 15, 10, 0, 0, 0, ZoneOffset.UTC)
    return PlanWithDayEntries().apply {
      plan = PlanEntity(
        id = id,
        userId = userId,
        name = name,
        current = false,
        createdAt = createdAt,
      )
      planDayEntries = (1 until 8).map { index ->
        PlanDayEntryEntity(
          id = index,
          planId = id,
          dayOfWeek = index,
          title = "-",
          start = createdAt.withHour(8).withMinute(0),
          end = createdAt.withHour(8).withMinute(45),
        )
      }
    }
  }

  private fun createPlan(id: Int, name: String): Plan {
    val createdAt = OffsetDateTime.of(2021, 11, 15, 10, 0, 0, 0, ZoneOffset.UTC)
    return Plan(
      id = id,
      name = name,
      current = false,
      createdAt = createdAt,
      days = (1 until 8).map { index ->
        Day(
          ordinal = index,
          dayOfWeek = DayOfWeek.of(index),
          date = OffsetDateTime.of(2021, 11, 14 + index, 0, 0, 0, 0, ZoneOffset.UTC),
          entries = listOf(
            DayEntry(
              id = index,
              ordinal = 0,
              title = "-",
              start = createdAt.withHour(8).withMinute(0),
              end = createdAt.withHour(8).withMinute(45),
              pauseMinutes = 0
            )
          )
        )
      }
    )
  }

}