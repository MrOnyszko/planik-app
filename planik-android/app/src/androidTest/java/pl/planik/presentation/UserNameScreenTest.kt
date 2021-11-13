package pl.planik.presentation

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.user.name.UserNameScreen
import pl.planik.presentation.user.name.UserNameState

@RunWith(AndroidJUnit4::class)
class UserNameScreenTest {

  @get:Rule
  val composeTestRule = createComposeRule()

  @Test
  fun userNameScreen_displaysLoading() {
    composeTestRule.setContent {
      AppTheme {
        UserNameScreen(
          onConfirm = {},
          viewState = UserNameState.Empty.copy(isLoading = true),
          submitAction = {}
        )
      }
    }
    composeTestRule.onNodeWithTag("CircularProgressIndicator").assertIsDisplayed()
  }

  @Test
  fun userNameScreen_displaysContentWithNameProvided() {
    composeTestRule.setContent {
      AppTheme {
        UserNameScreen(
          onConfirm = {},
          viewState = UserNameState(
            name = "User"
          ),
          submitAction = {}
        )
      }
    }
    composeTestRule.onNodeWithTag("CircularProgressIndicator").assertDoesNotExist()

    composeTestRule.onNodeWithText("Planik").assertIsDisplayed()
    composeTestRule.onNodeWithText("Welcome in,\nPlanik!").assertIsDisplayed()
    composeTestRule.onNodeWithText("Provide your Nickname").assertIsDisplayed()
    composeTestRule.onNodeWithText("Confirm").assertIsDisplayed()
  }

  @Test
  fun userNameScreen_displaysContent_NameBeingProvided() {
    composeTestRule.setContent {
      AppTheme {
        UserNameScreen(
          onConfirm = {},
          viewState = UserNameState.Empty,
          submitAction = {}
        )
      }
    }
    composeTestRule.onNodeWithTag("CircularProgressIndicator").assertDoesNotExist()

    composeTestRule.onNodeWithText("Planik").assertIsDisplayed()
    composeTestRule.onNodeWithText("Welcome in,\nPlanik!").assertIsDisplayed()
    composeTestRule.onNodeWithText("Provide your Nickname").assertIsDisplayed()
      .performTextInput("User")
    composeTestRule.onNodeWithText("Confirm").assertIsDisplayed().performClick()
  }

  @Test
  fun userNameScreen_displaysContent_UserCreated() {
    composeTestRule.setContent {
      AppTheme {
        UserNameScreen(
          onConfirm = {},
          viewState = UserNameState.Empty.copy(created = true),
          submitAction = {}
        )
      }
    }
    composeTestRule.onNodeWithTag("CircularProgressIndicator").assertDoesNotExist()

    composeTestRule.onNodeWithText("Planik").assertIsDisplayed()
    composeTestRule.onNodeWithText("Let\'s create\na new Plan!").assertIsDisplayed()
    composeTestRule.onNodeWithText("Go").assertIsDisplayed().performClick()
  }
}