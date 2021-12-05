package pl.planik.domain

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Rule
import org.junit.Test
import org.mockito.kotlin.mock
import org.mockito.kotlin.whenever
import pl.planik.MainCoroutineScopeRule
import pl.planik.domain.model.NewUser
import pl.planik.domain.model.User
import pl.planik.domain.service.UserService
import pl.planik.domain.source.UserLocalSource
import java.util.*

@ExperimentalCoroutinesApi
class UserServiceTest {

  @get:Rule
  val instantTaskExecutorRule = InstantTaskExecutorRule()

  @get:Rule
  val coroutineScope = MainCoroutineScopeRule()

  private val userLocalSourceMock: UserLocalSource = mock()

  private val userService = UserService(
    userLocalSource = userLocalSourceMock,
  )

  @Test
  fun should_returnHasUserTrue_When_UserWasCreated() {
    whenever(userLocalSourceMock.hasUser()).thenReturn(true)

    val hasUser = userService.hasUser()
    assert(hasUser)
  }

  @Test
  fun should_returnHasUserFalse_When_UserWasNotCreated() {
    whenever(userLocalSourceMock.hasUser()).thenReturn(false)

    val hasUser = userService.hasUser()
    assert(!hasUser)
  }

  @Test
  fun should_returnHasPlanTrue_When_AtLeastOnePlanWasCreated() {
    whenever(userLocalSourceMock.hasPlan()).thenReturn(true)

    val hasUser = userService.hasPlan()
    assert(hasUser)
  }

  @Test
  fun should_returnHasPlanFalse_When_AtLeastOnePlanWasNotCreated() {
    whenever(userLocalSourceMock.hasPlan()).thenReturn(false)

    val hasUser = userService.hasPlan()
    assert(!hasUser)
  }

  @Test
  fun should_returnCurrentUser_When_UserWasCreated() {
    coroutineScope.runBlockingTest {
      val expectedUser = User(
        id = 1,
        uuid = UUID.randomUUID(),
        nickname = "User"
      )
      whenever(userLocalSourceMock.getCurrentUser()).thenAnswer { expectedUser }

      val user = userService.getCurrentUser()
      assertThat(user, equalTo(expectedUser))
    }
  }

  @Test
  fun should_returnNullCurrentUser_When_UserWasNotCreated() {
    coroutineScope.runBlockingTest {
      whenever(userLocalSourceMock.getCurrentUser()).thenAnswer { null }

      val user = userService.getCurrentUser()
      assertThat(user, equalTo(null))
    }
  }

  @Test
  fun should_createUser_When_NicknameWasProvided() {
    coroutineScope.runBlockingTest {
      val newUser = NewUser(nickname = "User")
      val expectedUser = User(
        id = 1,
        uuid = UUID.randomUUID(),
        nickname = "User"
      )
      whenever(userLocalSourceMock.createUser(newUser)).thenAnswer { expectedUser }

      val user = userService.createUser("User")
      assertThat(user, equalTo(expectedUser))
    }
  }
}
