package pl.planik.presentation.plan

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Scaffold
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController
import pl.planik.app.ui.theme.AppTheme

@Composable
fun HomeScreen(
  navController: NavController,
) {
  Scaffold(
    topBar = {
      TopAppBar(
        title = {
          Text("HomeScreen")
        },
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
    HomeScreen(rememberNavController())
  }
}