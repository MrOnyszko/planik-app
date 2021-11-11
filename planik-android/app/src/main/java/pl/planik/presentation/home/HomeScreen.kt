package pl.planik.presentation.home

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Text
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

@Composable
fun HomeScreen() {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      TopAppBar(
        title = {
          Text(stringResource(id = R.string.app_name))
        },
        contentPadding = rememberInsetsPaddingValues(
          insets = LocalWindowInsets.current.systemBars,
          applyBottom = false,
        )
      )
    },
    content = { padding ->
      Column(
        modifier = Modifier.padding(padding),
        verticalArrangement = Arrangement.Center
      ) {
        Text(text = "HomeScreen")
      }
    }
  )
}

@Preview(showBackground = true, widthDp = 320)
@Composable
fun HomeScreen_Preview() {
  AppTheme {
    HomeScreen()
  }
}