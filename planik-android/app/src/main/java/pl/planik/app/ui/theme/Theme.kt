package pl.planik.app.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material.MaterialTheme
import androidx.compose.material.darkColors
import androidx.compose.material.lightColors
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

private val DarkColorPalette = darkColors(
  surface = Color.Black,
  onSurface = Color.White,
  primary = Color.Black,
  onPrimary = Color.White,
)

private val LightColorPalette = lightColors(
  surface = Color.White,
  onSurface = Color.Black,
  primary = Color.White,
  onPrimary = Color.Black,
)

@Composable
fun AppTheme(
  darkTheme: Boolean = isSystemInDarkTheme(),
  content: @Composable () -> Unit
) {
  val colors = if (darkTheme) {
    DarkColorPalette
  } else {
    LightColorPalette
  }

  MaterialTheme(
      colors = colors,
      typography = Typography,
      shapes = Shapes,
      content = content
  )
}