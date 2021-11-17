package pl.planik.app

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import pl.planik.presentation.plan.PlanScreen
import pl.planik.presentation.plans.PlansScreen
import pl.planik.presentation.splash.SplashScreen
import pl.planik.presentation.user.name.UserNameScreen

sealed class Screen(val route: String) {
  object Splash : Screen("/")
  object Plan : Screen("/plan")
  object CreateUser : Screen("/create-user")
  object Plans : Screen("/plans")
}

@Composable
fun AppNavigation(appViewModel: AppViewModel) {
  val navController = rememberNavController()
  NavHost(
    navController = navController,
    startDestination = Screen.Splash.route,
  ) {
    composable(Screen.Splash.route) {
      SplashScreen()
    }
    composable(Screen.Plan.route) {
      PlanScreen()
    }
    composable(Screen.CreateUser.route) {
      UserNameScreen(
        onConfirm = {
          navController.navigate(Screen.Plan.route) {
            popUpTo(Screen.Splash.route) {
              inclusive = true
            }
          }
        }
      )
    }
    composable(Screen.Plans.route) {
      PlansScreen(
        onBack = {
          navController.popBackStack()
        },
      )
    }
  }

  navController.navigate(if (appViewModel.hasUser) Screen.Plan.route else Screen.CreateUser.route)
}