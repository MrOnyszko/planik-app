package pl.planik.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.runtime.Composable
import androidx.hilt.navigation.compose.hiltViewModel
import dagger.hilt.android.AndroidEntryPoint
import pl.planik.app.ui.theme.AppTheme

@AndroidEntryPoint
class AppActivity : ComponentActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContent {
      AppTheme {
        PlanikApp()
      }
    }
  }
}

@Composable
fun PlanikApp(
  appViewModel: AppViewModel = hiltViewModel()
) {
  AppNavigation(appViewModel)
}