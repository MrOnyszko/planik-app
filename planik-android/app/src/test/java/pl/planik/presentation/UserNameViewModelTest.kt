package pl.planik.presentation

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.take
import kotlinx.coroutines.flow.toList
import kotlinx.coroutines.launch
import kotlinx.coroutines.test.TestCoroutineDispatcher
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Assert.assertEquals
import org.junit.Rule
import org.junit.Test
import org.mockito.kotlin.mock
import org.mockito.kotlin.whenever
import pl.planik.MainCoroutineScopeRule
import pl.planik.domain.model.User
import pl.planik.domain.service.UserService
import pl.planik.presentation.user.name.UserNameAction
import pl.planik.presentation.user.name.UserNameState
import pl.planik.presentation.user.name.UserNameViewModel
import java.time.OffsetDateTime
import java.util.*

@ExperimentalCoroutinesApi
class UserNameViewModelTest {

  private val testDispatcher = TestCoroutineDispatcher()

  @get:Rule
  val instantTaskExecutorRule = InstantTaskExecutorRule()

  @get:Rule
  val coroutineScope = MainCoroutineScopeRule()

  private val userServiceMock: UserService = mock()

  private val userNameViewModel = UserNameViewModel(
    dispatcher = testDispatcher,
    userService = userServiceMock
  )

  @Test
  fun provideUserName() {
    coroutineScope.runBlockingTest {
      userNameViewModel.submitAction(UserNameAction.NameTextChanges("U"))
      userNameViewModel.submitAction(UserNameAction.NameTextChanges("Us"))
      userNameViewModel.submitAction(UserNameAction.NameTextChanges("Use"))
      userNameViewModel.submitAction(UserNameAction.NameTextChanges("User"))

      coroutineScope.launch {
        val currentStates = userNameViewModel.state.take(10).toList()

        val states = listOf(
          UserNameState.Empty,
          UserNameState.Empty.copy(name = "U"),
          UserNameState.Empty.copy(name = "Us"),
          UserNameState.Empty.copy(name = "Use"),
          UserNameState.Empty.copy(name = "User"),
        )

        assertEquals(currentStates, states)
      }
    }
  }

  @Test
  fun confirmsUserCreation() {
    coroutineScope.runBlockingTest {
      whenever(userServiceMock.createUser(nickname = "User")).thenAnswer {
        User(
          id = 1,
          uuid = UUID.fromString("User"),
          nickname = "User",
          createdAt = OffsetDateTime.MAX
        )
      }

      userNameViewModel.submitAction(UserNameAction.NameTextChanges("User"))
      userNameViewModel.submitAction(UserNameAction.Confirm)

      coroutineScope.launch {
        val currentStates = userNameViewModel.state.take(10).toList()

        val states = listOf(
          UserNameState.Empty,
          UserNameState.Empty.copy(name = "User"),
          UserNameState.Empty.copy(name = "User", isLoading = true),
          UserNameState.Empty.copy(name = "User", isLoading = false, created = true),
        )

        assertEquals(currentStates, states)
      }
    }
  }
}