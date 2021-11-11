package pl.planik.app.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material.MaterialTheme
import androidx.compose.material.darkColors
import androidx.compose.material.lightColors
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

private val LightThemeColors = lightColors(
  primary = Color700,
  primaryVariant = Color900,
  onPrimary = Color.White,
  secondary = Color700,
  secondaryVariant = Color900,
  onSecondary = Color.White,
  error = Color800,
  onBackground = Color.Black
)

private val DarkThemeColors = darkColors(
  primary = Color300,
  primaryVariant = Color700,
  onPrimary = Color.Black,
  secondary = Color300,
  onSecondary = Color.Black,
  error = Color200,
  onBackground = Color.White
)

@Composable
fun AppTheme(
  darkTheme: Boolean = isSystemInDarkTheme(),
  content: @Composable () -> Unit
) {
  val colors = if (darkTheme) {
    DarkThemeColors
  } else {
    LightThemeColors
  }

  MaterialTheme(
    colors = colors,
    typography = Typography,
    shapes = Shapes,
    content = content
  )
}