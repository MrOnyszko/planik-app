package pl.planik.presentation.common

import androidx.compose.foundation.layout.RowScope
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import com.google.accompanist.insets.LocalWindowInsets
import com.google.accompanist.insets.rememberInsetsPaddingValues
import com.google.accompanist.insets.ui.TopAppBar
import pl.planik.R

@Composable
fun PlanikAppBar(
  modifier: Modifier = Modifier,
  navigationIcon: @Composable (() -> Unit)? = null,
  actions: @Composable RowScope.() -> Unit = {},
) {
  TopAppBar(
    title = {
      Text(stringResource(id = R.string.app_name))
    },
    navigationIcon = navigationIcon,
    actions = actions,
    modifier = modifier,
    contentPadding = rememberInsetsPaddingValues(
      insets = LocalWindowInsets.current.systemBars,
      applyBottom = false,
    )
  )
}