package pl.planik.presentation.create.day.entry

import androidx.lifecycle.SavedStateHandle
import androidx.navigation.NamedNavArgument
import androidx.navigation.NavType
import androidx.navigation.navArgument
import pl.planik.app.ScreenRoute
import java.time.DayOfWeek
import javax.inject.Inject

object CreateDayEntryRoute : ScreenRoute.Route() {
  const val planIdArgName = "planId"
  const val dayOfWeekArgName = "dayOfWeek"

  private const val name = "create-day-entry"

  override val routeName: String
    get() = "$name/{$planIdArgName}/{$dayOfWeekArgName}"

  fun createRoute(
    planId: Int,
    dayOfWeek: DayOfWeek,
  ): String = "$name/${planId}/${dayOfWeek.value}"

  fun arguments(): List<NamedNavArgument> {
    return listOf(
      navArgument(name = planIdArgName) {
        type = NavType.IntType
      },
      navArgument(name = dayOfWeekArgName) {
        type = NavType.IntType
      }
    )
  }
}

class CreateDayEntryRouteArguments @Inject constructor(private val savedStateHandle: SavedStateHandle) {
  val planId: Int by lazy {
    savedStateHandle.get<Int>(CreateDayEntryRoute.planIdArgName)
      ?: throw IllegalArgumentException()
  }

  val dayOfWeek: DayOfWeek by lazy {
    val value = savedStateHandle.get<Int>(CreateDayEntryRoute.dayOfWeekArgName)
      ?: throw IllegalArgumentException()
    DayOfWeek.of(value)
  }
}
