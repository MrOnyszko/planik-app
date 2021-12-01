package pl.planik.presentation.create.plan

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import pl.planik.R
import pl.planik.presentation.common.TimeSelection
import java.time.OffsetTime

@Composable
fun DayEntryForm(
  name: String,
  isError: Boolean = false,
  focusRequester: FocusRequester,
  submitAction: (CreatePlanAction) -> Unit,
  onSend: () -> Unit,
) {
  Column(
    Modifier
      .fillMaxWidth()
      .padding(horizontal = dimensionResource(id = R.dimen.medium))
      .height(dimensionResource(id = R.dimen.bottomSheet))
  ) {
    Spacer(Modifier.height(dimensionResource(id = R.dimen.medium)))
    Row(
      modifier = Modifier.fillMaxWidth(),
      horizontalArrangement = Arrangement.SpaceAround,
    ) {
      TimeSelection(
        isError = isError,
        modifier = Modifier.weight(0.5f),
        resLabelId = R.string.create_plan_screen_entry_start_input_placeholder,
        value = OffsetTime.now(),
        valueChanged = { value ->
          submitAction(CreatePlanAction.DayEntryStartChanges(value))
        }
      )
      Spacer(Modifier.width(dimensionResource(id = R.dimen.medium)))
      TimeSelection(
        isError = isError,
        modifier = Modifier.weight(0.5f),
        resLabelId = R.string.create_plan_screen_entry_end_input_placeholder,
        value = OffsetTime.now(),
        valueChanged = { value ->
          submitAction(CreatePlanAction.DayEntryEndChanges(value))
        }
      )
    }
    Spacer(Modifier.height(dimensionResource(id = R.dimen.medium)))
    DayEntryNameInput(
      isError = isError,
      text = name,
      onSend = onSend,
      onValueChange = { value ->
        submitAction(CreatePlanAction.DayEntryNameTextChanges(value.text))
      },
      focusRequester = focusRequester
    )
  }

}

@Composable
private fun DayEntryNameInput(
  text: String = "",
  isError: Boolean = false,
  onSend: () -> Unit,
  onValueChange: (TextFieldValue) -> Unit,
  focusRequester: FocusRequester,
) {
  var textFieldValue by remember { mutableStateOf(TextFieldValue(text = text)) }

  OutlinedTextField(
    isError = isError,
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
    singleLine = true,
  )
}