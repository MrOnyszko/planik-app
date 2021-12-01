package pl.planik.presentation.create.plan

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
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
import pl.planik.R

@Composable
fun PlanCreatedThankYouContent(
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