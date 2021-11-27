package pl.planik.presentation.create.plan

import androidx.lifecycle.SavedStateHandle
import androidx.navigation.NamedNavArgument
import androidx.navigation.NavType
import androidx.navigation.navArgument
import pl.planik.app.ScreenRoute
import javax.inject.Inject

object CreatePlanRoute : ScreenRoute.Route() {
  const val planIdArgName = "planId"

  override val routeName: String
    get() = "create-plan/{$planIdArgName}"

  fun createRoute(planId: Int? = null): String = "create-plan/${planId ?: -1}"

  fun arguments(): List<NamedNavArgument> {
    return listOf(
      navArgument(name = planIdArgName) {
        type = NavType.IntType
      }
    )
  }
}

class CreatePlanRouteArguments @Inject constructor(private val savedStateHandle: SavedStateHandle) {
  val planId: Int? by lazy {
    savedStateHandle.get<Int>(CreatePlanRoute.planIdArgName)
      .takeIf { it != null && it > 0 }
  }
}
