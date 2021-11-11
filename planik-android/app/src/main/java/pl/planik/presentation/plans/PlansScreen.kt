package pl.planik.presentation.plans

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.material.Scaffold
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController
import pl.planik.app.ui.theme.AppTheme

@Composable
fun PlansScreen(
  navController: NavController,
) {
  Scaffold(
    topBar = {
      TopAppBar(
        title = {
          Text("PlansScreen")
        }
      )
    },
    content = {
      Column(verticalArrangement = Arrangement.Center) {
        Text(text = "PlansScreen")
      }
    }
  )
}

@Preview(showBackground = true, widthDp = 320)
@Composable
fun HomeScreen_Preview() {
  AppTheme {
    PlansScreen(rememberNavController())
  }
}