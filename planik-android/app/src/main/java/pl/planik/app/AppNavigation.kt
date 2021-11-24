package pl.planik.app

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.navigation.NavController
import androidx.navigation.NavOptions
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navOptions
import com.google.accompanist.pager.ExperimentalPagerApi
import pl.planik.presentation.create.plan.CreatePlanIncentiveScreen
import pl.planik.presentation.create.plan.CreatePlanScreen
import pl.planik.presentation.plan.PlanScreen
import pl.planik.presentation.plans.PlansScreen
import pl.planik.presentation.splash.SplashScreen
import pl.planik.presentation.user.name.UserNameScreen

sealed class Screen(val route: String) {
  object Splash : Screen("/splash")
  object Plan : Screen("/plan")
  object CreateUser : Screen("/create-user")
  object CreatePlan : Screen("/create-plan")
  object CreatePlanIncentive : Screen("/create-plan-incentive")
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
          navController.navigate(Screen.CreatePlanIncentive.route) {
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
          navController.navigateUp()
        },
      )
    }
    composable(Screen.CreatePlan.route) {
      CreatePlanScreen(
        onNavigateUp = navController.canPop {
          navController.popBackStack()
        },
        onThankYouPrimaryAction = {
          navController.navigate(
            Screen.Plan.route,
            Screen.CreatePlan.popUpInclusiveTo()
          )
        }
      )
    }
    composable(Screen.CreatePlanIncentive.route) {
      CreatePlanIncentiveScreen(
        onPrimaryAction = {
          navController.navigate(
            Screen.CreatePlan.route,
            Screen.CreatePlanIncentive.popUpInclusiveTo()
          )
        }
      )
    }
  }

  LaunchedEffect(appViewModel.hasUser) {
    navController.navigate(
      when {
        appViewModel.hasUser -> {
          if (appViewModel.hasPlan) {
            Screen.Plan.route
          } else {
            Screen.CreatePlanIncentive.route
          }
        }
        else -> Screen.CreateUser.route
      },
      Screen.Splash.popUpInclusiveTo()
    )
  }
}

fun NavController.canPop(block: () -> Unit) = when {
  backQueue.isNotEmpty() && backQueue.size > 2 -> block // it's 2 because backQueue keeps start destination
  else -> null
}

fun Screen.popUpInclusiveTo(): NavOptions {
  return navOptions {
    popUpTo(route) { inclusive = true }
  }
}