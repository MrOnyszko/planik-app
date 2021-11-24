package pl.planik.presentation.create.plan

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.DoneAll
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.LocalWindowInsets
import com.google.accompanist.insets.rememberInsetsPaddingValues
import com.google.accompanist.insets.ui.Scaffold
import com.google.accompanist.pager.ExperimentalPagerApi
import com.google.accompanist.pager.rememberPagerState
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.common.*
import pl.planik.presentation.plan.PlanPager

@Composable
fun CreatePlanScreen(
  onThankYouPrimaryAction: () -> Unit,
  onNavigateUp: (() -> Unit)? = null,
  viewModel: CreatePlanViewModel = hiltViewModel(),
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = CreatePlanState())

  CreatePlanScreen(
    onNavigateUp = onNavigateUp,
    onThankYouPrimaryAction = onThankYouPrimaryAction,
    viewState = viewState,
    submitAction = viewModel::submitAction
  )
}

@Composable
internal fun CreatePlanScreen(
  onThankYouPrimaryAction: () -> Unit,
  onNavigateUp: (() -> Unit)? = null,
  viewState: CreatePlanState,
  submitAction: (CreatePlanAction) -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      PlanikAppBar(
        titleId = R.string.create_plan_screen_title,
        elevation = 0.dp,
        navigationIcon = onNavigateUp?.let { { NavigationBackIcon(onNavigateUp) } },
        actions = {
          if (!viewState.created) {
            IconButton(
              onClick = {
                submitAction(CreatePlanAction.Done)
              }
            ) {
              Icon(
                imageVector = Icons.Filled.DoneAll,
                contentDescription = stringResource(
                  id = R.string.plan_screen_done_all_action_content_description
                )
              )
            }
          }
        }
      )
    },
    floatingActionButton = {
      ExtendedFloatingActionButton(
        text = {
          Text(stringResource(id = R.string.create_plan_screen_add_entry))
        },
        onClick = {}
      )
    },
    contentPadding = rememberInsetsPaddingValues(
      insets = LocalWindowInsets.current.navigationBars,
      applyTop = false,
    ),
    content = { paddingValues ->
      viewState.stateStatus.When(
        loaded = {
          if (viewState.created) {
            PlanCreatedThankYouContent(paddingValues, onThankYouPrimaryAction)
          } else {
            CreatePlanForm(paddingValues, submitAction, viewState)
          }
        }
      )
    }
  )
}

@Composable
private fun PlanNameInput(
  value: String,
  submitAction: (CreatePlanAction) -> Unit
) {
  Surface(color = MaterialTheme.colors.primary) {
    Column(modifier = Modifier.padding(top = dimensionResource(id = R.dimen.small))) {
      var textFieldValue by remember { mutableStateOf(TextFieldValue(text = value)) }
      val focusManager = LocalFocusManager.current

      TextField(
        value = textFieldValue,
        onValueChange = { value ->
          textFieldValue = value
          submitAction(CreatePlanAction.PlanNameTextChanges(value.text))
        },
        modifier = Modifier
          .fillMaxWidth()
          .padding(horizontal = dimensionResource(id = R.dimen.large)),
        placeholder = {
          Text(
            text = stringResource(id = R.string.user_name_screen_input_placeholder),
            color = MaterialTheme.colors.onPrimary,
          )
        },
        keyboardActions = KeyboardActions(
          onDone = {
            submitAction(CreatePlanAction.UpdatePlanName)
            focusManager.clearFocus()
          }
        ),
        keyboardOptions = KeyboardOptions(
          imeAction = ImeAction.Done,
        ),
        maxLines = 1,
        colors = TextFieldDefaults.textFieldColors(
          cursorColor = MaterialTheme.colors.onPrimary,
        )
      )
    }
  }
}

@OptIn(ExperimentalPagerApi::class)
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
  ) {
    PlanNameInput(
      viewState.name,
      submitAction,
    )

    val pagerState = rememberPagerState()
    PlanPager(pagerState, viewState.days)
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
      onNavigateUp = {},
      onThankYouPrimaryAction = {},
      viewState = CreatePlanState(stateStatus = StateStatus.LOADED, created = false),
      submitAction = {}
    )
  }
}

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun CreatePlanScreen_Created_Preview() {
  AppTheme {
    CreatePlanScreen(
      onNavigateUp = {},
      onThankYouPrimaryAction = {},
      viewState = CreatePlanState(stateStatus = StateStatus.LOADED, created = true),
      submitAction = {}
    )
  }
}