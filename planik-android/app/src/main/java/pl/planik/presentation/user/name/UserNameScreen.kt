package pl.planik.presentation.user.name

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.LocalWindowInsets
import com.google.accompanist.insets.rememberInsetsPaddingValues
import com.google.accompanist.insets.ui.Scaffold
import com.google.accompanist.insets.ui.TopAppBar
import pl.planik.app.ui.theme.AppTheme
import pl.planik.presentation.common.rememberFlowWithLifecycle

@Composable
fun UserNameScreen(
  onConfirm: () -> Unit,
) {
  UserNameScreen(
    onConfirm = onConfirm,
    viewModel = hiltViewModel()
  )
}

@Composable
internal fun UserNameScreen(
  onConfirm: () -> Unit,
  viewModel: UserNameViewModel,
) {

  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = UserNameState.Empty)

  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      TopAppBar(
        title = {
          Text("Planik")
        },
        contentPadding = rememberInsetsPaddingValues(
          insets = LocalWindowInsets.current.systemBars,
          applyBottom = false,
        )
      )
    },
    content = { paddingValues ->
      when {
        viewState.isLoading -> CircularProgressIndicator()
        viewState.created -> {
          Column(
            modifier = Modifier
              .fillMaxWidth()
              .padding(paddingValues),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
          ) {
            Spacer(Modifier.height(64.dp))
            Text(text = "Let's create", style = MaterialTheme.typography.h4)
            Text(text = "a new Plan!", style = MaterialTheme.typography.h4)
            Spacer(Modifier.height(48.dp))
            Button(
              onClick = onConfirm,
              modifier = Modifier
                .fillMaxWidth()
                .height(48.dp)
                .padding(horizontal = 24.dp),
              enabled = viewState.isConfirmEnabled,
            ) {
              Text(text = "Finish")
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
            Text(text = "Welcome in,", style = MaterialTheme.typography.h4)
            Text(text = "Planik!", style = MaterialTheme.typography.h3)
            Spacer(Modifier.height(48.dp))

            var text by remember { mutableStateOf(TextFieldValue()) }

            OutlinedTextField(
              value = text,
              onValueChange = { value ->
                text = value
                viewModel.submitAction(UserNameAction.NameTextChanges(value.text))
              },
              modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp),
              placeholder = {
                Text("Provide your Nickname")
              },
              keyboardOptions = KeyboardOptions(
                imeAction = ImeAction.Done
              ),
              maxLines = 1
            )

            Spacer(Modifier.height(24.dp))

            Button(
              onClick = {
                viewModel.submitAction(UserNameAction.Confirm)
              },
              modifier = Modifier
                .fillMaxWidth()
                .height(48.dp)
                .padding(horizontal = 24.dp),
              enabled = viewState.isConfirmEnabled,
            ) {
              Text(text = "Confirm")
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