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
import pl.planik.presentation.create.day.entry.CreateDayEntryRoute
import pl.planik.presentation.create.day.entry.CreateDayEntryScreen
import pl.planik.presentation.create.plan.CreatePlanRoute
import pl.planik.presentation.create.plan.CreatePlanScreen
import pl.planik.presentation.create.plan.incentive.CreatePlanIncentiveRoute
import pl.planik.presentation.create.plan.incentive.CreatePlanIncentiveScreen
import pl.planik.presentation.plan.PlanRoute
import pl.planik.presentation.plan.PlanScreen
import pl.planik.presentation.plans.PlansRoute
import pl.planik.presentation.plans.PlansScreen
import pl.planik.presentation.splash.SplashRoute
import pl.planik.presentation.splash.SplashScreen
import pl.planik.presentation.user.name.UserNameRoute
import pl.planik.presentation.user.name.UserNameScreen

sealed class ScreenRoute {
  abstract val routeName: String

  abstract class Route : ScreenRoute()
}

@ExperimentalFoundationApi
@ExperimentalPagerApi
@Composable
fun AppNavigation(appViewModel: AppViewModel) {
  val navController = rememberNavController()
  NavHost(
    navController = navController,
    startDestination = SplashRoute.routeName,
  ) {
    composable(SplashRoute.routeName) {
      SplashScreen()
    }
    composable(PlanRoute.routeName) {
      PlanScreen(
        onPlansOpen = {
          navController.navigate(PlansRoute.routeName)
        }
      )
    }
    composable(UserNameRoute.routeName) {
      UserNameScreen(
        onConfirm = {
          navController.navigate(
            CreatePlanIncentiveRoute.routeName,
            UserNameRoute.popUpInclusiveTo()
          )
        }
      )
    }
    composable(PlansRoute.routeName) {
      PlansScreen(
        onCreatePlanOpen = {
          navController.navigate(CreatePlanRoute.createRoute())
        },
        onBack = {
          navController.navigateUp()
        },
        onPlanOpen = { id ->
          navController.navigate(CreatePlanRoute.createRoute(id))
        }
      )
    }
    composable(
      route = CreatePlanRoute.routeName,
      arguments = CreatePlanRoute.arguments()
    ) {
      CreatePlanScreen(
        onNavigateUp = navController.canPop {
          navController.popBackStack()
        },
        onPrimaryAction = { planId, dayOfWeek, dayEntryId ->
          navController.navigate(
            CreateDayEntryRoute.createRoute(planId, dayOfWeek, dayEntryId),
          )
        },
        onThankYouPrimaryAction = {
          navController.navigate(
            PlanRoute.routeName,
            CreatePlanRoute.popUpInclusiveTo()
          )
        }
      )
    }
    composable(CreatePlanIncentiveRoute.routeName) {
      CreatePlanIncentiveScreen(
        onPrimaryAction = {
          navController.navigate(
            CreatePlanRoute.createRoute(),
            CreatePlanIncentiveRoute.popUpInclusiveTo()
          )
        }
      )
    }
    composable(
      route = CreateDayEntryRoute.routeName,
      arguments = CreateDayEntryRoute.arguments(),
    ) {
      CreateDayEntryScreen(
        onNavigateUp = navController.canPop {
          navController.popBackStack()
        },
        onPrimaryAction = {
          navController.popBackStack()
        }
      )
    }
  }

  LaunchedEffect(appViewModel.hasUser) {
    navController.navigate(
      when {
        appViewModel.hasUser -> {
          if (appViewModel.hasPlan) {
            PlanRoute.routeName
          } else {
            CreatePlanIncentiveRoute.routeName
          }
        }
        else -> UserNameRoute.routeName
      },
      SplashRoute.popUpInclusiveTo()
    )
  }
}

fun NavController.canPop(block: () -> Unit) = when {
  backQueue.isNotEmpty() && backQueue.size > 2 -> block // it's 2 because backQueue keeps start destination
  else -> null
}

fun ScreenRoute.popUpInclusiveTo(): NavOptions {
  return navOptions {
    popUpTo(routeName) { inclusive = true }
  }
}
