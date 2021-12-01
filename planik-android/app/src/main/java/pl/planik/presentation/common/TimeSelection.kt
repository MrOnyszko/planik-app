package pl.planik.presentation.common

import android.app.TimePickerDialog
import androidx.annotation.StringRes
import androidx.compose.foundation.clickable
import androidx.compose.material.ContentAlpha
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.LocalContentAlpha
import androidx.compose.material.LocalContentColor
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.material.TextFieldDefaults
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowDropDown
import androidx.compose.material.icons.filled.Clear
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import pl.planik.R
import pl.planik.app.LocalDateFormatter
import java.time.OffsetTime

@Composable
fun TimeSelection(
  @StringRes resLabelId: Int,
  modifier: Modifier = Modifier,
  value: OffsetTime,
  isError: Boolean = false,
  valueChanged: (value: OffsetTime) -> Unit
) {
  val localFormatter = LocalDateFormatter.current
  val time = remember {
    mutableStateOf(localFormatter.formatShortTime(value))
  }

  val dialog = TimePickerDialog(
    LocalContext.current,
    { _, hour: Int, minute: Int ->
      val offsetTime = OffsetTime.now().withHour(hour).withMinute(minute)
      time.value = localFormatter.formatShortTime(offsetTime)
      valueChanged(offsetTime)
    },
    value.hour,
    value.minute,
    localFormatter.is24hClock()
  )

  OutlinedTextField(
    modifier = modifier.clickable { dialog.show() },
    value = time.value,
    label = {
      Text(text = stringResource(id = resLabelId))
    },
    trailingIcon = {
      if (time.value.isNotBlank()) {
        IconButton(
          onClick = { time.value = "" }
        ) {
          Icon(
            imageVector = Icons.Filled.Clear,
            contentDescription = stringResource(
              id = R.string.time_selection_clear_action_content_description
            )
          )
        }
      } else {
        Icon(
          imageVector = Icons.Filled.ArrowDropDown,
          contentDescription = stringResource(
            id = R.string.time_selection_dropdown_action_content_description
          )
        )
      }
    },
    isError = isError,
    onValueChange = {},
    readOnly = true,
    enabled = false,
    colors = TextFieldDefaults.outlinedTextFieldColors(
      disabledTextColor = LocalContentColor.current.copy(LocalContentAlpha.current),
      disabledBorderColor = MaterialTheme.colors.primary.copy(alpha = ContentAlpha.disabled),
      disabledLabelColor = MaterialTheme.colors.primary.copy(ContentAlpha.medium)
    )
  )
}
