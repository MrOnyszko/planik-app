package pl.planik.presentation.plans

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.FloatingActionButton
import androidx.compose.material.Icon
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.PlusOne
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import com.google.accompanist.insets.LocalWindowInsets
import com.google.accompanist.insets.rememberInsetsPaddingValues
import com.google.accompanist.insets.ui.Scaffold
import com.google.accompanist.insets.ui.TopAppBar
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.common.NavigationBackIcon

@Composable
fun PlansScreen(
  onCreatePlanOpen: () -> Unit,
  onBack: () -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      TopAppBar(
        title = {
          Text(stringResource(id = R.string.app_name))
        },
        navigationIcon = {
          NavigationBackIcon(onBack)
        },
        contentPadding = rememberInsetsPaddingValues(
          insets = LocalWindowInsets.current.systemBars,
          applyBottom = false,
        )
      )
    },
    floatingActionButton = {
      FloatingActionButton(
        onClick = onCreatePlanOpen
      ) {
        Icon(
          imageVector = Icons.Filled.PlusOne,
          contentDescription = ""
        )
      }
    },
    contentPadding = rememberInsetsPaddingValues(
      insets = LocalWindowInsets.current.navigationBars,
      applyTop = false,
    ),
    content = {}
  )
}

@Preview(showBackground = true, widthDp = 320)
@Composable
fun PlansScreen_Preview() {
  AppTheme {
    PlansScreen(
      onCreatePlanOpen = {},
      onBack = {}
    )
  }
}