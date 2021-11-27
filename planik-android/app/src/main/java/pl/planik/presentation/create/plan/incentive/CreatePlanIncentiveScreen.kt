package pl.planik.presentation.create.plan.incentive

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.google.accompanist.insets.ui.Scaffold
import pl.planik.R
import pl.planik.presentation.common.PlanikAppBar

@Composable
fun CreatePlanIncentiveScreen(
  onPrimaryAction: () -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = { PlanikAppBar() },
    content = { paddingValues ->
      CreatePlanIncentiveContent(
        paddingValues = paddingValues,
        onConfirm = onPrimaryAction
      )
    }
  )
}

@Composable
private fun CreatePlanIncentiveContent(
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
      text = stringResource(id = R.string.create_plan_incentive_screen_header),
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
      Text(text = stringResource(id = R.string.create_plan_incentive_screen_go))
    }
  }
}