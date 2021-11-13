package pl.planik.presentation.user.name

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.LocalWindowInsets
import com.google.accompanist.insets.rememberInsetsPaddingValues
import com.google.accompanist.insets.ui.Scaffold
import com.google.accompanist.insets.ui.TopAppBar
import pl.planik.R
import pl.planik.app.ui.theme.AppTheme
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
    topBar = {
      TopAppBar(
        title = {
          Text(stringResource(id = R.string.app_name))
        },
        contentPadding = rememberInsetsPaddingValues(
          insets = LocalWindowInsets.current.systemBars,
          applyBottom = false,
        )
      )
    },
    content = { paddingValues ->
      when {
        viewState.isLoading -> CircularProgressIndicator(
          modifier = Modifier.semantics {
            testTag = "CircularProgressIndicator"
          }
        )
        viewState.created -> {
          Column(
            modifier = Modifier
              .fillMaxWidth()
              .padding(paddingValues),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
          ) {
            Spacer(Modifier.height(64.dp))
            Text(
              text = stringResource(id = R.string.user_name_thank_you_screen_header),
              style = MaterialTheme.typography.h4,
              textAlign = TextAlign.Center,
            )
            Spacer(Modifier.height(48.dp))
            Button(
              onClick = onConfirm,
              modifier = Modifier
                .fillMaxWidth()
                .height(48.dp)
                .padding(horizontal = 24.dp),
              enabled = viewState.isConfirmEnabled,
            ) {
              Text(text = stringResource(id = R.string.user_name_thank_you_screen_go))
            }
          }
        }
        else -> {
          Column(
            modifier = Modifier
              .fillMaxWidth()
              .padding(paddingValues),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
          ) {
            Spacer(Modifier.height(64.dp))
            Text(
              text = stringResource(id = R.string.user_name_screen_header),
              style = MaterialTheme.typography.h4,
              textAlign = TextAlign.Center
            )
            Spacer(Modifier.height(48.dp))

            var text by remember { mutableStateOf(TextFieldValue()) }

            OutlinedTextField(
              value = text,
              onValueChange = { value ->
                text = value
                submitAction(UserNameAction.NameTextChanges(value.text))
              },
              modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp),
              placeholder = {
                Text(stringResource(id = R.string.user_name_screen_input_placeholder))
              },
              keyboardOptions = KeyboardOptions(
                imeAction = ImeAction.Done
              ),
              maxLines = 1
            )

            Spacer(Modifier.height(24.dp))

            Button(
              onClick = {
                submitAction(UserNameAction.Confirm)
              },
              modifier = Modifier
                .fillMaxWidth()
                .height(48.dp)
                .padding(horizontal = 24.dp),
              enabled = viewState.isConfirmEnabled,
            ) {
              Text(stringResource(id = R.string.user_name_screen_confirm))
            }
          }
        }
      }
    }
  )
}

@Preview(showBackground = true, widthDp = 320)
@Composable
fun HomeScreen_Preview() {
  AppTheme {
    UserNameScreen(
      onConfirm = {}
    )
  }
}