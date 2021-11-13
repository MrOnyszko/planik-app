package pl.planik.presentation.common

import androidx.compose.material.CircularProgressIndicator
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag

const val LoadingTestTag = "LoadingTestTag"

@Composable
fun Loading() {
  CircularProgressIndicator(
    modifier = Modifier.semantics {
      testTag = LoadingTestTag
    }
  )
}