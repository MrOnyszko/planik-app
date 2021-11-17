package pl.planik.presentation.user.name

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.ui.Scaffold
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.common.Loading
import pl.planik.presentation.common.PlanikAppBar
import pl.planik.presentation.common.rememberFlowWithLifecycle

@Composable
fun UserNameScreen(
  onConfirm: () -> Unit,
  viewModel: UserNameViewModel = hiltViewModel(),
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = UserNameState.Empty)

  UserNameScreen(
    onConfirm = onConfirm,
    viewState = viewState,
    submitAction = viewModel::submitAction
  )
}

@Composable
internal fun UserNameScreen(
  onConfirm: () -> Unit,
  viewState: UserNameState,
  submitAction: (UserNameAction) -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = { PlanikAppBar() },
    content = { paddingValues ->
      when {
        viewState.isLoading -> Loading()
        viewState.created -> UserCreatedThankYouContent(paddingValues, onConfirm)
        else -> UserNameForm(paddingValues, submitAction, viewState)
      }
    }
  )
}

@Composable
private fun UserNameForm(
  paddingValues: PaddingValues,
  submitAction: (UserNameAction) -> Unit,
  viewState: UserNameState
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
      text = stringResource(id = R.string.user_name_screen_header),
      style = MaterialTheme.typography.h4,
      textAlign = TextAlign.Center
    )
    Spacer(Modifier.height(dimensionResource(id = R.dimen.xBig)))

    var text by remember { mutableStateOf(TextFieldValue()) }

    OutlinedTextField(
      value = text,
      onValueChange = { value ->
        text = value
        submitAction(UserNameAction.NameTextChanges(value.text))
      },
      modifier = Modifier
        .fillMaxWidth()
        .padding(horizontal = dimensionResource(id = R.dimen.large)),
      placeholder = {
        Text(stringResource(id = R.string.user_name_screen_input_placeholder))
      },
      keyboardOptions = KeyboardOptions(
        imeAction = ImeAction.Done
      ),
      maxLines = 1
    )

    Spacer(Modifier.height(dimensionResource(id = R.dimen.large)))

    Button(
      onClick = {
        submitAction(UserNameAction.Confirm)
      },
      modifier = Modifier
        .fillMaxWidth()
        .height(dimensionResource(id = R.dimen.xBig))
        .padding(horizontal = dimensionResource(id = R.dimen.large)),
      enabled = viewState.isConfirmEnabled,
    ) {
      Text(stringResource(id = R.string.user_name_screen_confirm))
    }
  }
}

@Composable
private fun UserCreatedThankYouContent(
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
      text = stringResource(id = R.string.user_name_thank_you_screen_header),
      style = MaterialTheme.typography.h4,
      textAlign = TextAlign.Center,
    )
    Spacer(Modifier.height(dimensionResource(id = R.dimen.xBig)))
    Button(
      onClick = onConfirm,
      modifier = Modifier
        .fillMaxWidth()
        .height(48.dp)
        .padding(horizontal = dimensionResource(id = R.dimen.large)),
    ) {
      Text(text = stringResource(id = R.string.user_name_thank_you_screen_go))
    }
  }
}

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun UserNameScreen_Form_Preview() {
  AppTheme {
    UserNameScreen(
      onConfirm = {},
      viewState = UserNameState.Empty,
      submitAction = {}
    )
  }
}

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun UserNameScreen_Created_Preview() {
  AppTheme {
    UserNameScreen(
      onConfirm = {},
      viewState = UserNameState.Empty.copy(created = true),
      submitAction = {}
    )
  }
}