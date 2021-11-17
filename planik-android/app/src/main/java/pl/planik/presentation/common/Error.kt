package pl.planik.presentation.common

import androidx.annotation.StringRes
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import pl.planik.R

const val ErrorTestTag = "ErrorTestTag"

@Composable
fun Error(@StringRes id: Int = R.string.default_error_text) {
  Text(
    text = stringResource(id = id),
    modifier = Modifier.semantics {
      testTag = ErrorTestTag
    }
  )
}