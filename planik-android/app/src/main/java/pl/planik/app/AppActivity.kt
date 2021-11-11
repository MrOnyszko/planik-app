package pl.planik.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.runtime.Composable
import androidx.core.view.WindowCompat
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.ProvideWindowInsets
import dagger.hilt.android.AndroidEntryPoint
import pl.planik.app.ui.theme.AppTheme

@AndroidEntryPoint
class AppActivity : ComponentActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    WindowCompat.setDecorFitsSystemWindows(window, false)

    setContent {
      AppTheme {
        ProvideWindowInsets {
          PlanikApp()
        }
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