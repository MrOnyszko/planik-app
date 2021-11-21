package pl.planik.local

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.TestCoroutineDispatcher
import kotlinx.coroutines.test.runBlockingTest
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Rule
import org.junit.Test
import org.mockito.kotlin.*
import pl.planik.MainCoroutineScopeRule
import pl.planik.domain.model.NewUser
import pl.planik.local.dao.UsersDao
import pl.planik.local.entity.UserEntity
import pl.planik.local.mapper.to.entity.NewUserToEntityMapper
import pl.planik.local.mapper.to.model.UserEntityToModelMapper
import pl.planik.local.source.UserLocalSourceImpl
import java.util.*

@ExperimentalCoroutinesApi
class UserLocalSourceTest {

  private val testDispatcher = TestCoroutineDispatcher()

  @get:Rule
  val instantTaskExecutorRule = InstantTaskExecutorRule()

  @get:Rule
  val coroutineScope = MainCoroutineScopeRule()

  private val usersDaoMock: UsersDao = mock()
  private val userPreferencesMock: UserPreferences = mock()

  private val newUserToEntityMapper = NewUserToEntityMapper()
  private val userEntityToModelMapper = UserEntityToModelMapper()

  private val userLocalSource = UserLocalSourceImpl(
    usersDao = usersDaoMock,
    usersPreferences = userPreferencesMock,
    newUserToEntityMapper = newUserToEntityMapper,
    userEntityToModelMapper = userEntityToModelMapper,
  )

  @Test
  fun should_returnNullCurrentUserId_When_UserWasNotCreated() {
    whenever(userPreferencesMock.id).thenReturn(-1)

    val currentUserId = userLocalSource.currentUserId()
    assert(currentUserId == null)
  }

  @Test
  fun should_returnCurrentUserId_When_UserWasCreated() {
    whenever(userPreferencesMock.id).thenReturn(1)

    val currentUserId = userLocalSource.currentUserId()
    assertThat(currentUserId, equalTo(1))
  }


  @Test
  fun should_returnHasUserFalse_When_UserWasNotCreated() {
    whenever(userPreferencesMock.uuid).thenReturn(null)

    val hasUser = userLocalSource.hasUser()
    assertThat(hasUser, equalTo(false))
  }

  @Test
  fun should_returnHasUserFalse_When_UserWasCreated() {
    whenever(userPreferencesMock.uuid).thenReturn(UUID.randomUUID().toString())

    val hasUser = userLocalSource.hasUser()
    assertThat(hasUser, equalTo(true))
  }

  @Test
  fun should_returnGetCurrentUserNull_When_UserWasNotCreated() {
    whenever(userPreferencesMock.uuid).thenReturn(null)

    coroutineScope.runBlockingTest {
      val user = userLocalSource.getCurrentUser()
      assertThat(user, equalTo(null))
    }
  }

  @Test
  fun should_returnGetCurrentUser_When_UserWasCreated() {
    coroutineScope.runBlockingTest {
      val givenUuid = UUID.fromString("6e6f26ed-a78d-4ea8-8db9-fcab355f24f9")

      whenever(userPreferencesMock.uuid).thenReturn(givenUuid.toString())

      whenever(usersDaoMock.queryUser(givenUuid)).thenAnswer {
        UserEntity(
          uuid = UUID.randomUUID(),
          nickname = "User"
        ).apply {
          id = 1
        }
      }

      val user = userLocalSource.getCurrentUser()
      assert(user != null)
      assertThat(user?.nickname, equalTo("User"))
    }
  }

  @Test
  fun should_returnGetCurrentUserNull_When_DidNotFindUserWithSpecifiedIdentifier() {
    whenever(userPreferencesMock.uuid).thenReturn("75e8d5d4-c7eb-44b8-bcf7-74991472ef3f")

    coroutineScope.runBlockingTest {
      val user = userLocalSource.getCurrentUser()
      assert(user == null)
    }
  }

  @Test
  fun should_CreateUser_When_NicknameIsProvided() {
    coroutineScope.runBlockingTest {

      val userId = 1
      val nickname = "Nickname"
      val expectedUuid = UUID.nameUUIDFromBytes(nickname.toByteArray())

      whenever(userPreferencesMock.uuid).thenReturn(expectedUuid.toString())
      whenever(usersDaoMock.insert(any())).thenAnswer { userId }
      whenever(usersDaoMock.queryUser(expectedUuid)).thenAnswer {
        UserEntity(
          uuid = expectedUuid,
          nickname = nickname
        ).apply {
          id = userId
        }
      }

      val newUser = NewUser(nickname = nickname)
      val user = userLocalSource.createUser(newUser)

      verify(userPreferencesMock.id) { times(1) }
      verify(userPreferencesMock.uuid) { times(1) }

      assertThat(user?.nickname, equalTo(nickname))
      assertThat(user?.uuid, equalTo(expectedUuid))
    }
  }
}