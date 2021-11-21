package pl.planik.local

import android.content.Context
import android.database.sqlite.SQLiteConstraintException
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.asExecutor
import kotlinx.coroutines.test.runBlockingTest
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import pl.planik.TestCoroutineScopeRule
import pl.planik.local.dao.PlansDao
import pl.planik.local.dao.UsersDao
import pl.planik.local.entity.PlanEntity
import pl.planik.local.entity.UserEntity
import java.util.*

@ExperimentalCoroutinesApi
@RunWith(AndroidJUnit4::class)
class PlansDaoTest {

  @get:Rule
  val coroutineScope = TestCoroutineScopeRule()

  private lateinit var plansDao: PlansDao
  private lateinit var usersDao: UsersDao
  private lateinit var db: LocalDatabase

  @Before
  fun setUp() {
    val context = ApplicationProvider.getApplicationContext<Context>()
    db = Room.inMemoryDatabaseBuilder(context, LocalDatabase::class.java)
      .apply {
        setTransactionExecutor(coroutineScope.dispatcher.asExecutor())
        setQueryExecutor(coroutineScope.dispatcher.asExecutor())
      }.build()

    plansDao = db.plansDao()
    usersDao = db.usersDao()
  }

  @After
  fun tearDown() {
    db.close()
  }

  @Test(expected = SQLiteConstraintException::class)
  fun should_ThrowSQLiteConstraintException_When_InsertPlanButThereIsNoUser() {
    coroutineScope.runBlockingTest {
      val entity = createPlan()
      val id = plansDao.insert(entity)
      val insertedPlan = plansDao.queryById(id.toInt())
      assertThat(insertedPlan, equalTo(entity))
    }
  }

  @Test
  fun should_InsertPlan_When_ThereIsUser() {
    coroutineScope.runBlockingTest {
      val userId = usersDao.insert(UserEntity(uuid = UUID.randomUUID(), nickname = "Name"))
      val entity = createPlan().copy(userId = userId.toInt())
      val id = plansDao.insert(entity)
      val insertedPlan = plansDao.queryById(id.toInt())
      assertThat(insertedPlan, equalTo(entity))
    }
  }

  private fun createPlan() = PlanEntity(
    userId = 1,
    name = "Plan",
    current = true,
  )
}
