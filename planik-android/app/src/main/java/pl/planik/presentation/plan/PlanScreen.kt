package pl.planik.presentation.plan

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Today
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.google.accompanist.insets.ui.Scaffold
import kotlinx.coroutines.launch
import pl.planik.R
import pl.planik.app.LocalDateFormatter
import pl.planik.app.ui.theme.AppTheme
import pl.planik.app.ui.theme.Gray100
import pl.planik.app.ui.theme.Gray800
import pl.planik.domain.model.Day
import pl.planik.domain.model.DayEntry
import pl.planik.presentation.common.PlanikAppBar
import pl.planik.presentation.common.When
import pl.planik.presentation.common.rememberFlowWithLifecycle

@Composable
fun PlanScreen(
  viewModel: PlanViewModel = hiltViewModel(),
) {
  val viewState by rememberFlowWithLifecycle(viewModel.state)
    .collectAsState(initial = PlanState())

  PlanScreen(
    viewState = viewState,
    submitAction = viewModel::submitAction
  )
}

@Composable
internal fun PlanScreen(
  viewState: PlanState,
  submitAction: (PlanAction) -> Unit,
) {
  Scaffold(
    modifier = Modifier.fillMaxSize(),
    topBar = {
      PlanikAppBar(
        actions = {
          IconButton(
            onClick = {
              submitAction(PlanAction.Today)
            }
          ) {
            Icon(
              imageVector = Icons.Filled.Today,
              contentDescription = stringResource(
                id = R.string.plan_screen_today_action_content_description
              )
            )
          }
        }
      )
    },
    content = { paddingValues ->
      viewState.stateStatus.When(
        loaded = { Plan(paddingValues, viewState) }
      )
    }
  )
}

@Composable
private fun Plan(
  paddingValues: PaddingValues,
  viewState: PlanState
) {
  Column(
    modifier = Modifier
      .fillMaxWidth()
      .padding(paddingValues),
  ) {
    Days(
      scrollToItem = viewState.indexOfCurrentDay,
      entries = viewState.days
    )
  }
}

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun Days(
  scrollToItem: Int? = null,
  entries: List<Day>
) {
  val listState = rememberLazyListState()
  val coroutineScope = rememberCoroutineScope()

  scrollToItem?.let {
    LaunchedEffect(listState) {
      coroutineScope.launch {
        listState.animateScrollToItem(scrollToItem, 420)
      }
    }
  }

  LazyColumn(state = listState) {
    entries.forEach { day ->
      stickyHeader {
        DayHeader(day)
      }
      items(day.entries) { dayEntry ->
        DayEntryItem(dayEntry)
      }
    }
    item {
      Spacer(modifier = Modifier.height(dimensionResource(id = R.dimen.xBig)))
    }
  }
}

@Composable
private fun DayHeader(day: Day) {
  val localFormatter = LocalDateFormatter.current

  Surface(
    elevation = 0.5.dp
  ) {
    Row(
      Modifier
        .background(MaterialTheme.colors.background)
        .padding(all = dimensionResource(id = R.dimen.medium))
        .fillMaxSize(),
      horizontalArrangement = Arrangement.SpaceBetween,
      verticalAlignment = Alignment.CenterVertically
    ) {
      Text(
        localFormatter.formatDayName(day.date),
        textAlign = TextAlign.Start,
        style = MaterialTheme.typography.subtitle1.copy(fontWeight = FontWeight.Bold)
      )
      Spacer(Modifier.width(dimensionResource(id = R.dimen.large)))
      Text(
        localFormatter.formatShortDate(day.date),
        textAlign = TextAlign.Start,
      )
    }
  }
}

@Composable
fun DayEntryItem(dayEntry: DayEntry) {

  val localFormatter = LocalDateFormatter.current
  val formattedStartTime = localFormatter.formatShortTime(dayEntry.start.toLocalTime())
  val formattedEndTime = localFormatter.formatShortTime(dayEntry.end.toLocalTime())
  val timeRange = "$formattedStartTime -- $formattedEndTime"

  Column {
    Row(
      verticalAlignment = Alignment.CenterVertically
    ) {
      Text(
        text = dayEntry.ordinal.toString(),
        textAlign = TextAlign.Center,
        modifier = Modifier
          .width(dimensionResource(id = R.dimen.xLarge))
          .padding(start = dimensionResource(id = R.dimen.tiny)),
        style = MaterialTheme.typography.caption
      )
      Column(
        modifier = Modifier.padding(
          top = dimensionResource(id = R.dimen.small),
          start = dimensionResource(id = R.dimen.tiny),
          bottom = dimensionResource(id = R.dimen.tiny),
        )
      ) {
        Text(
          text = dayEntry.title,
          style = MaterialTheme.typography.subtitle1.copy(fontWeight = FontWeight.Bold)
        )
        Text(
          text = timeRange,
          style = MaterialTheme.typography.body2
        )
      }
    }
    PauseBar(dayEntry = dayEntry)
  }
}

@Composable
private fun PauseBar(
  dayEntry: DayEntry,
  isDarkTheme: Boolean = isSystemInDarkTheme(),
) {
  // todo: find a better way
  val color = if (isDarkTheme) {
    Gray800
  } else {
    Gray100
  }
  Text(
    text = "${dayEntry.pauseMinutes}",
    textAlign = TextAlign.End,
    style = MaterialTheme.typography.caption,
    modifier = Modifier
      .fillMaxWidth()
      .background(color)
      .padding(
        top = dimensionResource(id = R.dimen.tiny),
        bottom = dimensionResource(id = R.dimen.tiny),
        start = dimensionResource(id = R.dimen.tiny),
        end = dimensionResource(id = R.dimen.small)
      )
  )
}

@Preview(showBackground = true, widthDp = 320, heightDp = 640)
@Composable
fun PlanScreen_Form_Preview() {
  AppTheme {
    PlanScreen(
      viewState = PlanState(),
      submitAction = {}
    )
  }
}