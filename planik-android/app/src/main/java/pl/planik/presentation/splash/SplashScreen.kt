package pl.planik.presentation.splash

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import com.google.accompanist.insets.ui.Scaffold
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme

@Composable
fun SplashScreen() {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    content = { padding ->
      Column(
        modifier = Modifier
          .fillMaxSize()
          .padding(padding),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally,
      ) {
        Text(text = stringResource(id = R.string.app_name))
      }
    }
  )
}

@Preview(showBackground = true, widthDp = 320)
@Composable
fun SplashScreen_Preview() {
  AppTheme {
    SplashScreen()
  }
}