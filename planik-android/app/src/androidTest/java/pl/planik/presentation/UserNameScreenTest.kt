package pl.planik.presentation

import androidx.compose.ui.test.assertIsDisplayed
import androidx.compose.ui.test.junit4.AndroidComposeTestRule
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performTextInput
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import pl.planik.R
import pl.planik.app.AppActivity
import pl.planik.app.ui.theme.AppTheme
import pl.planik.onNodeWithString
import pl.planik.presentation.common.LoadingTestTag
import pl.planik.presentation.user.name.UserNameScreen
import pl.planik.presentation.user.name.UserNameState

@RunWith(AndroidJUnit4::class)
class UserNameScreenTest {

  @get:Rule
  val composeTestRule: AndroidComposeTestRule<ActivityScenarioRule<AppActivity>, AppActivity> =
    createAndroidComposeRule<AppActivity>()

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
    composeTestRule.onNodeWithTag(LoadingTestTag).assertIsDisplayed()
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
    composeTestRule.onNodeWithTag(LoadingTestTag).assertDoesNotExist()

    composeTestRule.onNodeWithString(R.string.app_name).assertIsDisplayed()
    composeTestRule.onNodeWithString(R.string.user_name_screen_header).assertIsDisplayed()
    composeTestRule.onNodeWithString(R.string.user_name_screen_input_placeholder)
      .assertIsDisplayed()
    composeTestRule.onNodeWithString(R.string.user_name_screen_confirm).assertIsDisplayed()
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
    composeTestRule.onNodeWithTag(LoadingTestTag).assertDoesNotExist()

    composeTestRule.onNodeWithString(R.string.app_name).assertIsDisplayed()
    composeTestRule.onNodeWithString(R.string.user_name_screen_header).assertIsDisplayed()
    composeTestRule.onNodeWithString(R.string.user_name_screen_input_placeholder)
      .assertIsDisplayed()
      .performTextInput("User")
    composeTestRule.onNodeWithString(R.string.user_name_screen_confirm).performClick()
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
    composeTestRule.onNodeWithTag(LoadingTestTag).assertDoesNotExist()

    composeTestRule.onNodeWithString(R.string.app_name).assertIsDisplayed()
    composeTestRule.onNodeWithString(R.string.user_name_thank_you_screen_header).assertIsDisplayed()
    composeTestRule.onNodeWithString(R.string.user_name_thank_you_screen_go).assertIsDisplayed()
      .performClick()
  }
}