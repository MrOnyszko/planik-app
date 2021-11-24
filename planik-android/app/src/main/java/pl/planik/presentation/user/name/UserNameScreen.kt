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
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.ui.Scaffold
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.common.PlanikAppBar
import pl.planik.presentation.common.rememberFlowWithLifecycle

@Composable
fun UserNameScreen(
  onConfirm: () -> Unit,
  viewModel: UserNameViewModel = hiltViewModel(),
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = UserNameState.Empty)

  if (viewState.userHasBeenCreated) {
    LaunchedEffect(viewState.userHasBeenCreated) {
      onConfirm()
    }
  }

  UserNameScreen(
    viewState = viewState,
    submitAction = viewModel::submitAction
  )
}

@Composable
internal fun UserNameScreen(
  viewState: UserNameState,
  submitAction: (UserNameAction) -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = { PlanikAppBar() },
    content = { paddingValues ->
      UserNameForm(paddingValues, submitAction, viewState)
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

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun UserNameScreen_Form_Preview() {
  AppTheme {
    UserNameScreen(
      viewState = UserNameState.Empty,
      submitAction = {}
    )
  }
}
