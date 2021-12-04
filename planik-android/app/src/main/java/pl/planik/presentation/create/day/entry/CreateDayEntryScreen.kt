package pl.planik.presentation.create.day.entry

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.Button
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.ui.Scaffold
import pl.planik.R
import pl.planik.presentation.common.NavigationBackIcon
import pl.planik.presentation.common.PlanikAppBar
import pl.planik.presentation.common.TimeSelection
import pl.planik.presentation.common.rememberFlowWithLifecycle

@Composable
fun CreateDayEntryScreen(
  onPrimaryAction: () -> Unit,
  onNavigateUp: (() -> Unit)? = null,
  viewModel: CreateDayEntryViewModel = hiltViewModel(),
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = CreateDayEntryState())

  if (viewState.created) {
    LaunchedEffect(viewState.created) {
      onPrimaryAction()
    }
  }

  CreateDayEntryScreen(
    viewState = viewState,
    onNavigateUp = onNavigateUp,
    submitAction = viewModel::submitAction
  )
}

@Composable
internal fun CreateDayEntryScreen(
  viewState: CreateDayEntryState,
  onNavigateUp: (() -> Unit)? = null,
  submitAction: (CreateDayEntryAction) -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      PlanikAppBar(
        navigationIcon = onNavigateUp?.let { { NavigationBackIcon(onNavigateUp) } },
      )
    },
    content = { paddingValues ->
      Column(
        Modifier
          .fillMaxWidth()
          .padding(horizontal = dimensionResource(id = R.dimen.medium))
          .padding(paddingValues)
      ) {
        Spacer(Modifier.height(dimensionResource(id = R.dimen.medium)))
        Row(
          modifier = Modifier.fillMaxWidth(),
          horizontalArrangement = Arrangement.SpaceAround,
        ) {
          TimeSelection(
            isError = viewState.hasDayEntryStart,
            modifier = Modifier.weight(0.5f),
            resLabelId = R.string.create_plan_screen_entry_start_input_placeholder,
            value = null,
            valueChanged = { value ->
              submitAction(CreateDayEntryAction.DayEntryStartChanges(value))
            }
          )
          Spacer(Modifier.width(dimensionResource(id = R.dimen.medium)))
          TimeSelection(
            isError = viewState.hasDayEntryEnd,
            modifier = Modifier.weight(0.5f),
            resLabelId = R.string.create_plan_screen_entry_end_input_placeholder,
            value = null,
            valueChanged = { value ->
              submitAction(CreateDayEntryAction.DayEntryEndChanges(value))
            }
          )
        }
        Spacer(Modifier.height(dimensionResource(id = R.dimen.medium)))
        DayEntryNameInput(
          isError = viewState.hasDayEntryName,
          text = viewState.dayEntryName ?: "",
          onValueChange = { value ->
            submitAction(CreateDayEntryAction.DayEntryNameTextChanges(value.text))
          },
        )
        Spacer(Modifier.height(dimensionResource(id = R.dimen.medium)))
        Button(
          onClick = {
            submitAction(CreateDayEntryAction.Confirm)
          },
          modifier = Modifier
            .fillMaxWidth()
            .height(dimensionResource(id = R.dimen.xBig)),
          enabled = viewState.isDayEntryFormValid,
        ) {
          Text(stringResource(id = R.string.user_name_screen_confirm))
        }
      }
    },
  )
}


@Composable
private fun DayEntryNameInput(
  text: String = "",
  isError: Boolean = false,
  onValueChange: (TextFieldValue) -> Unit,
) {
  var textFieldValue by remember { mutableStateOf(TextFieldValue(text = text)) }

  OutlinedTextField(
    isError = isError,
    value = textFieldValue,
    onValueChange = { value ->
      textFieldValue = value
      onValueChange(value)
    },
    modifier = Modifier.fillMaxWidth(),
    label = {
      Text(
        text = stringResource(id = R.string.create_plan_screen_entry_name_input_placeholder),
      )
    },
    keyboardOptions = KeyboardOptions(
      imeAction = ImeAction.Done,
    ),
    maxLines = 1,
    singleLine = true,
  )
}