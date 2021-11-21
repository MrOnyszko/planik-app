package pl.planik.app

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.google.accompanist.pager.ExperimentalPagerApi
import pl.planik.presentation.create.plan.CreatePlanScreen
import pl.planik.presentation.plan.PlanScreen
import pl.planik.presentation.plans.PlansScreen
import pl.planik.presentation.splash.SplashScreen
import pl.planik.presentation.user.name.UserNameScreen

sealed class Screen(val route: String) {
  object Splash : Screen("/")
  object Plan : Screen("/plan")
  object CreateUser : Screen("/create-user")
  object CreatePlan : Screen("/plans/create-plan")
  object Plans : Screen("/plans")
}

@ExperimentalFoundationApi
@ExperimentalPagerApi
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
      PlanScreen(
        onPlansOpen = {
          navController.navigate(Screen.Plans.route)
        }
      )
    }
    composable(Screen.CreateUser.route) {
      UserNameScreen(
        onConfirm = {
          navController.navigate(Screen.Plan.route) {
            popUpTo(Screen.CreateUser.route) {
              inclusive = true
            }
          }
        }
      )
    }
    composable(Screen.Plans.route) {
      PlansScreen(
        onCreatePlanOpen = {
          navController.navigate(Screen.CreatePlan.route)
        },
        onBack = {
          navController.popBackStack()
        },
      )
    }
    composable(Screen.CreatePlan.route) {
      CreatePlanScreen(
        onBack = {
          navController.popBackStack()
        },
        onFinish = {
          navController.navigate(Screen.Plan.route) {
            popUpTo(Screen.Splash.route) {
              inclusive = true
            }
          }
        }
      )
    }
  }

  LaunchedEffect(appViewModel.hasUser) {
    navController.navigate(
      if (appViewModel.hasUser) {
        Screen.Plan.route
      } else {
        Screen.CreateUser.route
      }
    ) {
      popUpTo(Screen.Splash.route) {
        inclusive = true
      }
    }
  }
}