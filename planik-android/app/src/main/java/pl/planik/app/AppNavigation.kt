package pl.planik.app

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import pl.planik.presentation.plan.HomeScreen
import pl.planik.presentation.plans.PlansScreen
import pl.planik.presentation.user.name.UserNameScreen

sealed class Screen(val route: String) {
  object Home : Screen("/home")
  object CreateUser : Screen("/create-user")
  object Plans : Screen("/plans")
}

@Composable
fun AppNavigation(appViewModel: AppViewModel) {
  val navController = rememberNavController()
  NavHost(
    navController = navController,
    startDestination = if (appViewModel.hasUser) Screen.Home.route else Screen.CreateUser.route,
  ) {
    composable(Screen.Home.route) {
      HomeScreen(
        navController = navController
      )
    }
    composable(Screen.CreateUser.route) {
      UserNameScreen(
        navController = navController
      )
    }
    composable(Screen.Plans.route) {
      PlansScreen(
        navController = navController
      )
    }
  }
}