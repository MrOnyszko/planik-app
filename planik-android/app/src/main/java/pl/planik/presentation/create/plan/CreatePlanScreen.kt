package pl.planik.presentation.create.plan

import androidx.compose.foundation.layout.*
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.ui.Scaffold
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.common.*

@Composable
fun CreatePlanScreen(
  onBack: () -> Unit,
  onFinish: () -> Unit,
  viewModel: CreatePlanViewModel = hiltViewModel(),
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = CreatePlanState())

  CreatePlanScreen(
    onBack = onBack,
    onFinish = onFinish,
    viewState = viewState,
    submitAction = viewModel::submitAction
  )
}

@Composable
internal fun CreatePlanScreen(
  onBack: () -> Unit,
  onFinish: () -> Unit,
  viewState: CreatePlanState,
  submitAction: (CreatePlanAction) -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      PlanikAppBar(
        titleId = R.string.create_plan_screen_title,
        navigationIcon = {
          NavigationBackIcon(onBack)
        },
      )
    },
    content = { paddingValues ->
      viewState.stateStatus.When(
        loaded = {
          if (viewState.created) {
            PlanCreatedThankYouContent(paddingValues, onFinish)
          } else {
            CreatePlanForm(paddingValues, submitAction, viewState)
          }
        }
      )
    }
  )
}

@Composable
private fun CreatePlanForm(
  paddingValues: PaddingValues,
  submitAction: (CreatePlanAction) -> Unit,
  viewState: CreatePlanState
) {
  Column(
    modifier = Modifier
      .fillMaxWidth()
      .padding(paddingValues),
    verticalArrangement = Arrangement.Center,
    horizontalAlignment = Alignment.CenterHorizontally
  ) {

  }
}

@Composable
private fun PlanCreatedThankYouContent(
  paddingValues: PaddingValues,
  onConfirm: () -> Unit,
) {
  Column(
    modifier = Modifier
      .fillMaxWidth()
      .padding(paddingValues),
    verticalArrangement = Arrangement.Center,
    horizontalAlignment = Alignment.CenterHorizontally
  ) {
    Spacer(Modifier.height(dimensionResource(id = R.dimen.huge)))
    Text(
      text = stringResource(id = R.string.create_plan_screen_thank_you_screen_header),
      style = MaterialTheme.typography.h4,
      textAlign = TextAlign.Center,
    )
    Spacer(Modifier.height(dimensionResource(id = R.dimen.xBig)))
    Button(
      onClick = onConfirm,
      modifier = Modifier
        .fillMaxWidth()
        .height(dimensionResource(id = R.dimen.xBig))
        .padding(horizontal = dimensionResource(id = R.dimen.large)),
    ) {
      Text(text = stringResource(id = R.string.create_plan_screen_thank_you_screen_primary_action))
    }
  }
}

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun CreatePlanScreen_Form_Preview() {
  AppTheme {
    CreatePlanScreen(
      onBack = {},
      onFinish = {},
      viewState = CreatePlanState(stateStatus = StateStatus.LOADED),
      submitAction = {}
    )
  }
}

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun CreatePlanScreen_Created_Preview() {
  AppTheme {
    CreatePlanScreen(
      onBack = {},
      onFinish = {},
      viewState = CreatePlanState(stateStatus = StateStatus.LOADED, created = true),
      submitAction = {}
    )
  }
}