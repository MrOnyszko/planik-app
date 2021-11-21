package pl.planik.local

import android.content.Context
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
import pl.planik.local.dao.UsersDao
import pl.planik.local.entity.UserEntity
import java.io.IOException
import java.time.OffsetDateTime
import java.time.ZoneOffset
import java.util.*

@ExperimentalCoroutinesApi
@RunWith(AndroidJUnit4::class)
class UsersDaoTest {

  @get:Rule
  val coroutineScope = TestCoroutineScopeRule()

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

    usersDao = db.usersDao()
  }

  @After
  @Throws(IOException::class)
  fun tearDown() {
    db.close()
  }

  @Test
  @Throws(Exception::class)
  fun insertsAndQueriesUserByUuid() {
    coroutineScope.runBlockingTest {
      val entity = createUser()
      usersDao.insert(entity)
      val createdUser = usersDao.queryUser(entity.uuid)
      assertThat(createdUser, equalTo(entity))
    }
  }

  @Test
  @Throws(Exception::class)
  fun updatesUser() {
    coroutineScope.runBlockingTest {
      val newUser = createUser()
      usersDao.insert(newUser)
      val createdUser = usersDao.queryUser(newUser.uuid)
      assertThat(createdUser, equalTo(newUser))

      val toUpdate = createdUser!!.copy(
        email = "user@email.com",
        updatedAt = OffsetDateTime.of(2021, 11, 14, 0, 0, 0, 0, ZoneOffset.UTC)
      )
      val result = usersDao.update(toUpdate)
      val updated = usersDao.queryUser(toUpdate.uuid)
      assertThat(updated, equalTo(toUpdate))
      assertThat(result, equalTo(1))
    }
  }

  private fun createUser(nickname: String = "User") = UserEntity(
    uuid = UUID.nameUUIDFromBytes(nickname.toByteArray()),
    nickname = nickname,
    email = "email",
    createdAt = OffsetDateTime.MAX,
  )
}