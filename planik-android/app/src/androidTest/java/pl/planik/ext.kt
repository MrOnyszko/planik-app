package pl.planik

import androidx.annotation.StringRes
import androidx.compose.ui.test.junit4.AndroidComposeTestRule
import androidx.compose.ui.test.onNodeWithText
import androidx.test.ext.junit.rules.ActivityScenarioRule
import pl.planik.app.AppActivity

fun AndroidComposeTestRule<ActivityScenarioRule<AppActivity>, AppActivity>.getString(@StringRes id: Int): String =
  activity.getString(id)

fun AndroidComposeTestRule<ActivityScenarioRule<AppActivity>, AppActivity>.onNodeWithString(@StringRes id: Int) =
  onNodeWithText(getString(id))