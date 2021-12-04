package pl.planik.presentation.create.plan

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.ExtendedFloatingActionButton
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.material.TextFieldDefaults
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.DoneAll
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
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
import pl.planik.domain.model.DayEntry
import pl.planik.presentation.common.NavigationBackIcon
import pl.planik.presentation.common.PlanikAppBar
import pl.planik.presentation.common.StateStatus
import pl.planik.presentation.common.When
import pl.planik.presentation.common.rememberFlowWithLifecycle
import pl.planik.presentation.plan.PlanPager
import java.time.DayOfWeek

@Composable
fun CreatePlanScreen(
  onThankYouPrimaryAction: () -> Unit,
  onPrimaryAction: (planId: Int, dayOfWeek: DayOfWeek, dayEntryId: Int?) -> Unit,
  onNavigateUp: (() -> Unit)? = null,
  viewModel: CreatePlanViewModel = hiltViewModel(),
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = CreatePlanState())

  CreatePlanScreen(
    onPrimaryAction = onPrimaryAction,
    onNavigateUp = onNavigateUp,
    onThankYouPrimaryAction = onThankYouPrimaryAction,
    viewState = viewState,
    submitAction = viewModel::submitAction
  )
}

@OptIn(
  ExperimentalMaterialApi::class,
  ExperimentalAnimationApi::class,
  ExperimentalComposeUiApi::class,
)
@Composable
internal fun CreatePlanScreen(
  onPrimaryAction: (planId: Int, dayOfWeek: DayOfWeek, dayEntryId: Int?) -> Unit,
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
          if (viewState.doneAllVisible) {
            IconButton(
              onClick = { submitAction(CreatePlanAction.Done) }
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
    contentPadding = rememberInsetsPaddingValues(
      insets = LocalWindowInsets.current.navigationBars,
    ),
    content = { paddingValues ->
      viewState.stateStatus.When(
        loaded = {
          if (viewState.isThankYouVisible) {
            PlanCreatedThankYouContent(paddingValues, onThankYouPrimaryAction)
          } else {
            CreatePlanContent(
              paddingValues = paddingValues,
              viewState = viewState,
              submitAction = submitAction,
              onItemTap = { dayEntry ->
                onPrimaryAction(
                  viewState.plan?.id!!,
                  viewState.currentDayOfWeek,
                  dayEntry.id,
                )
              }
            )
          }
        }
      )
    },
    floatingActionButton = {
      ExtendedFloatingActionButton(
        text = {
          Text(stringResource(id = R.string.create_plan_screen_add_entry))
        },
        onClick = {
          onPrimaryAction(
            viewState.plan?.id!!,
            viewState.currentDayOfWeek,
            null, // dayEntryId
          )
        }
      )
    },
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
        label = {
          Text(
            text = stringResource(id = R.string.create_plan_screen_plan_name_input_placeholder),
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
private fun CreatePlanContent(
  paddingValues: PaddingValues,
  viewState: CreatePlanState,
  submitAction: (CreatePlanAction) -> Unit,
  onItemTap: (item: DayEntry) -> Unit,
) {
  Column(
    modifier = Modifier
      .fillMaxWidth()
      .padding(paddingValues),
  ) {
    PlanNameInput(
      viewState.planName,
      submitAction,
    )

    val pagerState = rememberPagerState()
    PlanPager(
      pagerState = pagerState,
      days = viewState.days,
      onDayChange = { dayOfWeek ->
        submitAction(CreatePlanAction.DayOfWeekChanges(dayOfWeek))
      },
      onItemTap = onItemTap
    )
  }
}

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun CreatePlanScreen_Form_Preview() {
  AppTheme {
    CreatePlanScreen(
      onPrimaryAction = { _, _, _ -> },
      onNavigateUp = {},
      onThankYouPrimaryAction = {},
      viewState = CreatePlanState(stateStatus = StateStatus.LOADED, isThankYouVisible = false),
      submitAction = {}
    )
  }
}

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun CreatePlanScreen_Created_Preview() {
  AppTheme {
    CreatePlanScreen(
      onPrimaryAction = { _, _, _ -> },
      onNavigateUp = {},
      onThankYouPrimaryAction = {},
      viewState = CreatePlanState(stateStatus = StateStatus.LOADED, isThankYouVisible = true),
      submitAction = {}
    )
  }
}