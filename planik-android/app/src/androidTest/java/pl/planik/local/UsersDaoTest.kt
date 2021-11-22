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
  fun should_InsertAndQueries_When_UserUuidIsProvided() {
    coroutineScope.runBlockingTest {
      val entity = createUser()
      usersDao.insert(entity)
      val createdUser = usersDao.queryUser(entity.uuid)
      assertThat(createdUser, equalTo(entity))
    }
  }

  @Test
  fun should_AddUserAndUpdateIt_When_UserWasAdded() {
    coroutineScope.runBlockingTest {
      val entity = createUser(nickname = "A")
      val userId = usersDao.insert(entity).toInt()
      val user = usersDao.queryUser(userId)

      val toUpdate = user!!.copy(nickname = "B").apply { id = userId }
      usersDao.update(toUpdate)
      val updatedUser = usersDao.queryUser(userId)

      assertThat(userId, equalTo(1))
      assertThat(user, equalTo(entity))
      assertThat(user.id, equalTo(1))
      assertThat(updatedUser?.nickname, equalTo("B"))
    }
  }

  private fun createUser(nickname: String = "User") = UserEntity(
    uuid = UUID.nameUUIDFromBytes(nickname.toByteArray()),
    nickname = nickname,
    email = "email",
    createdAt = OffsetDateTime.MAX,
  )
}