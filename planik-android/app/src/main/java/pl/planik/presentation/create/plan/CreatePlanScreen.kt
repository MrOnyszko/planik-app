package pl.planik.presentation.create.plan

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.BottomSheetScaffold
import androidx.compose.material.BottomSheetState
import androidx.compose.material.BottomSheetValue
import androidx.compose.material.Button
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.ExtendedFloatingActionButton
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.material.TextFieldDefaults
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.DoneAll
import androidx.compose.material.rememberBottomSheetScaffoldState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.pager.ExperimentalPagerApi
import com.google.accompanist.pager.rememberPagerState
import kotlinx.coroutines.launch
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.common.NavigationBackIcon
import pl.planik.presentation.common.PlanikAppBar
import pl.planik.presentation.common.StateStatus
import pl.planik.presentation.common.When
import pl.planik.presentation.common.rememberFlowWithLifecycle
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

@OptIn(ExperimentalMaterialApi::class, ExperimentalAnimationApi::class)
@Composable
internal fun CreatePlanScreen(
  onThankYouPrimaryAction: () -> Unit,
  onNavigateUp: (() -> Unit)? = null,
  viewState: CreatePlanState,
  submitAction: (CreatePlanAction) -> Unit,
) {
  val coroutineScope = rememberCoroutineScope()
  val focusManager = LocalFocusManager.current
  val focusRequester = remember { FocusRequester() }
  val fabVisible = remember { mutableStateOf(true) }
  val bottomSheetScaffoldState = rememberBottomSheetScaffoldState(
    bottomSheetState = BottomSheetState(BottomSheetValue.Collapsed)
  )

  fun toggleBottomSheet() {
    fabVisible.value = !fabVisible.value
    coroutineScope.launch {
      if (bottomSheetScaffoldState.bottomSheetState.isCollapsed) {
        bottomSheetScaffoldState.bottomSheetState.expand()
        focusManager.clearFocus()
        focusRequester.freeFocus()
        focusRequester.requestFocus()
      } else {
        focusRequester.freeFocus()
        focusManager.clearFocus()
        submitAction(CreatePlanAction.AddDayEntry)
        bottomSheetScaffoldState.bottomSheetState.collapse()
      }
    }
  }

  BottomSheetScaffold(
    scaffoldState = bottomSheetScaffoldState,
    modifier = Modifier.fillMaxSize(),
    topBar = {
      PlanikAppBar(
        titleId = R.string.create_plan_screen_title,
        elevation = 0.dp,
        navigationIcon = onNavigateUp?.let { { NavigationBackIcon(onNavigateUp) } },
        actions = {
          if (viewState.doneAllVisible) {
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
    content = { paddingValues ->
      viewState.stateStatus.When(
        loaded = {
          if (viewState.showThankYouScreen) {
            PlanCreatedThankYouContent(paddingValues, onThankYouPrimaryAction)
          } else {
            CreatePlanContent(paddingValues, submitAction, viewState)
          }
        }
      )
    },
    floatingActionButton = {
      AnimatedVisibility(
        visible = fabVisible.value && viewState.isFabVisible,
      ) {
        ExtendedFloatingActionButton(
          modifier = Modifier.padding(
            bottom = dimensionResource(id = R.dimen.bottomSheetFabPadding)
          ),
          text = {
            Text(stringResource(id = R.string.create_plan_screen_add_entry))
          },
          onClick = {
            toggleBottomSheet()
          }
        )
      }
    },
    sheetPeekHeight = 0.dp,
    sheetGesturesEnabled = false,
    sheetContent = {
      Column(
        Modifier
          .fillMaxWidth()
          .padding(horizontal = dimensionResource(id = R.dimen.medium))
          .height(dimensionResource(id = R.dimen.bottomSheet))
      ) {
        Spacer(Modifier.height(dimensionResource(id = R.dimen.medium)))
        Row(
          modifier = Modifier.fillMaxWidth(),
          verticalAlignment = Alignment.CenterVertically,
          horizontalArrangement = Arrangement.SpaceBetween,
        ) {
          Text(
            text = stringResource(id = R.string.create_plan_screen_add_entry),
            style = MaterialTheme.typography.h6,
            textAlign = TextAlign.Center,
          )
          ExtendedFloatingActionButton(
            modifier = Modifier,
            text = {
              Text(stringResource(id = R.string.create_plan_screen_save_action))
            },
            onClick = {
              toggleBottomSheet()
            }
          )
        }
        Spacer(Modifier.height(dimensionResource(id = R.dimen.large)))
        DayEntryNameInput(
          text = viewState.name,
          onSend = {
            toggleBottomSheet()
          },
          onValueChange = { value ->
            submitAction(CreatePlanAction.DayEntryNameTextChanges(value.text))
          },
          focusRequester = focusRequester
        )
      }
    },
  )
}

@Composable
private fun DayEntryNameInput(
  text: String = "",
  onSend: () -> Unit,
  onValueChange: (TextFieldValue) -> Unit,
  focusRequester: FocusRequester,
) {
  var textFieldValue by remember { mutableStateOf(TextFieldValue(text = text)) }

  OutlinedTextField(
    value = textFieldValue,
    onValueChange = { value ->
      textFieldValue = value
      onValueChange(value)
    },
    modifier = Modifier
      .fillMaxWidth()
      .focusRequester(focusRequester),
    label = {
      Text(
        text = stringResource(id = R.string.create_plan_screen_entry_name_input_placeholder),
      )
    },
    keyboardActions = KeyboardActions(
      onSend = {
        onSend()
      }
    ),
    keyboardOptions = KeyboardOptions(
      imeAction = ImeAction.Send,
    ),
    maxLines = 1,
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
      viewState = CreatePlanState(stateStatus = StateStatus.LOADED, showThankYouScreen = false),
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
      viewState = CreatePlanState(stateStatus = StateStatus.LOADED, showThankYouScreen = true),
      submitAction = {}
    )
  }
}