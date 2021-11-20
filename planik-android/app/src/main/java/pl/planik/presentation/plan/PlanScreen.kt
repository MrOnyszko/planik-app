package pl.planik.presentation.plan

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.List
import androidx.compose.material.icons.filled.Today
import androidx.compose.material.icons.filled.ToggleOff
import androidx.compose.material.icons.filled.ToggleOn
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.ui.Scaffold
import com.google.accompanist.pager.ExperimentalPagerApi
import com.google.accompanist.pager.rememberPagerState
import kotlinx.coroutines.launch
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.common.PlanikAppBar
import pl.planik.presentation.common.When
import pl.planik.presentation.common.rememberFlowWithLifecycle

@ExperimentalPagerApi
@ExperimentalFoundationApi
@Composable
fun PlanScreen(
  onPlansOpen: () -> Unit,
  viewModel: PlanViewModel = hiltViewModel(),
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = PlanState())

  PlanScreen(
    viewState = viewState,
    onPlansOpen = onPlansOpen,
    submitAction = viewModel::submitAction
  )
}

@ExperimentalPagerApi
@ExperimentalFoundationApi
@Composable
internal fun PlanScreen(
  viewState: PlanState,
  onPlansOpen: () -> Unit = {},
  submitAction: (PlanAction) -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      PlanikAppBar(
        actions = {
          IconButton(
            onClick = onPlansOpen
          ) {
            Icon(
              imageVector = Icons.Filled.List,
              contentDescription = stringResource(
                id = R.string.plan_screen_open_plans_action_content_description
              )
            )
          }
          IconButton(
            onClick = {
              submitAction(PlanAction.Today)
            }
          ) {
            Icon(
              imageVector = Icons.Filled.Today,
              contentDescription = stringResource(
                id = R.string.plan_screen_today_action_content_description
              )
            )
          }
          IconButton(
            onClick = {
              submitAction(PlanAction.TogglePlanViewType)
            }
          ) {
            Icon(
              imageVector = if (viewState.isVertical) {
                Icons.Filled.ToggleOn
              } else {
                Icons.Filled.ToggleOff
              },
              contentDescription = stringResource(
                id = R.string.plan_screen_toggle_plan_view_type_action_content_description
              )
            )
          }
        }
      )
    },
    content = { paddingValues ->
      viewState.stateStatus.When(
        loaded = { Plan(paddingValues, viewState) }
      )
    },
  )
}

@ExperimentalPagerApi
@ExperimentalFoundationApi
@Composable
private fun Plan(
  paddingValues: PaddingValues,
  viewState: PlanState
) {
  Column(
    modifier = Modifier
      .fillMaxWidth()
      .padding(paddingValues),
  ) {
    val coroutineScope = rememberCoroutineScope()

    if (viewState.isVertical) {
      val listState = rememberLazyListState()

      viewState.indexOfCurrentDayEntry?.let {
        LaunchedEffect(listState) {
          coroutineScope.launch {
            listState.animateScrollToItem(viewState.indexOfCurrentDayEntry, 0)
          }
        }
      }

      PlanStickyHeadersList(listState, viewState.days)
    } else {
      val pagerState = rememberPagerState()

      viewState.indexOfCurrentDay?.let {
        LaunchedEffect(pagerState) {
          coroutineScope.launch {
            pagerState.animateScrollToPage(viewState.indexOfCurrentDay)
          }
        }
      }

      PlanPager(pagerState, viewState.days)
    }
  }
}

@ExperimentalPagerApi
@ExperimentalFoundationApi
@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun PlanScreen_Form_Preview() {
  AppTheme {
    PlanScreen(
      viewState = PlanState(),
      submitAction = {}
    )
  }
}