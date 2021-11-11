package pl.planik.presentation.user.name

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.height
import androidx.compose.material.Button
import androidx.compose.material.Scaffold
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController
import pl.planik.app.Screen
import pl.planik.app.ui.theme.AppTheme

@Composable
fun UserNameScreen(
  navController: NavController,
) {
  Scaffold(
    topBar = {
      TopAppBar(
        modifier = Modifier.height(80.dp),
        navigationIcon = {
        },
        title = {
          Text("UserNameScreen")
        }
      )
    },
    content = {
      Column(verticalArrangement = Arrangement.Center) {
        Button(
          onClick = {
            navController.navigate(Screen.Home.route)
          }
        ) {

        Text(text = "UserNameScreen")
        }
      }
    }
  )
}

@Preview(showBackground = true, widthDp = 320)
@Composable
fun HomeScreen_Preview() {
  AppTheme {
    UserNameScreen(rememberNavController())
  }
}