package pl.planik.presentation.plans

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.PlusOne
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.paging.PagingData
import androidx.paging.compose.collectAsLazyPagingItems
import androidx.paging.compose.items
import com.google.accompanist.insets.LocalWindowInsets
import com.google.accompanist.insets.rememberInsetsPaddingValues
import com.google.accompanist.insets.ui.Scaffold
import kotlinx.coroutines.flow.Flow
import pl.planik.R
import pl.planik.app.LocalDateFormatter
import pl.planik.app.ui.theme.AppTheme
import pl.planik.domain.model.Plan
import pl.planik.presentation.common.NavigationBackIcon
import pl.planik.presentation.common.PlanikAppBar
import pl.planik.presentation.common.When
import pl.planik.presentation.common.rememberFlowWithLifecycle

@Composable
fun PlansScreen(
  onCreatePlanOpen: () -> Unit,
  onBack: () -> Unit,
  onPlanOpen: (id: Int?) -> Unit,
  viewModel: PlansViewModel = hiltViewModel()
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = PlansState())

  PlansScreen(
    viewState = viewState,
    plans = viewModel.plans,
    onCreatePlanOpen = onCreatePlanOpen,
    onBack = onBack,
    onPlanOpen = onPlanOpen,
  )
}

@Composable
fun PlansScreen(
  viewState: PlansState,
  plans: Flow<PagingData<Plan>>,
  onCreatePlanOpen: () -> Unit,
  onBack: () -> Unit,
  onPlanOpen: (id: Int?) -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      PlanikAppBar(
        titleId = R.string.plans_screen_title,
        navigationIcon = {
          NavigationBackIcon(onBack)
        }
      )
    },
    floatingActionButton = {
      FloatingActionButton(
        onClick = onCreatePlanOpen
      ) {
        Icon(
          imageVector = Icons.Filled.PlusOne,
          contentDescription = ""
        )
      }
    },
    contentPadding = rememberInsetsPaddingValues(
      insets = LocalWindowInsets.current.navigationBars,
      applyTop = false,
    ),
    content = { paddingValues ->
      viewState.stateStatus.When(
        loaded = {
          PlansList(paddingValues, plans, onPlanOpen)
        }
      )
    }
  )
}

@OptIn(ExperimentalMaterialApi::class)
@Composable
private fun PlansList(
  paddingValues: PaddingValues,
  plans: Flow<PagingData<Plan>>,
  onItemTap: (id: Int?) -> Unit,
) {
  val localFormatter = LocalDateFormatter.current

  val planItems = plans.collectAsLazyPagingItems()

  Column(
    modifier = Modifier
      .fillMaxWidth()
      .padding(paddingValues),
  ) {
    LazyColumn {
      items(planItems) { item ->
        ListItem(
          modifier = Modifier.clickable {
            onItemTap(item?.id)
          },
          text = {
            Text(
              text = item?.name ?: "",
            )
          },
          secondaryText = {
            Text(
              text = item?.createdAt?.let {
                localFormatter.formatMediumDate(it)
              } ?: ""
            )
          }
        )
        Divider()
      }
    }
  }
}

@Preview(showBackground = true, widthDp = 320)
@Composable
fun PlansScreen_Preview() {
  AppTheme {
    PlansScreen(
      onCreatePlanOpen = {},
      onBack = {},
      onPlanOpen = {}
    )
  }
}