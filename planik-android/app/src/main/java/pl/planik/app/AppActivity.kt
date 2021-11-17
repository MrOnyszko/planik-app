package pl.planik.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.core.view.WindowCompat
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.ProvideWindowInsets
import dagger.hilt.android.AndroidEntryPoint
import pl.planik.app.ui.theme.AppTheme
import javax.inject.Inject

@AndroidEntryPoint
class AppActivity : ComponentActivity() {

  @Inject
  internal lateinit var dateFormatter: DateFormatter

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    WindowCompat.setDecorFitsSystemWindows(window, false)

    setContent {
      AppTheme {
        CompositionLocalProvider(
          LocalDateFormatter provides dateFormatter
        ) {
          ProvideWindowInsets {
            PlanikApp()
          }
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

val LocalDateFormatter = staticCompositionLocalOf<DateFormatter> {
  error("DateFormatter not provided")
}