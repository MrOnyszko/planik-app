package pl.planik.presentation.plan

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.foundation.lazy.items
import androidx.compose.material.MaterialTheme
import androidx.compose.material.ScrollableTabRow
import androidx.compose.material.Surface
import androidx.compose.material.Tab
import androidx.compose.material.TabRowDefaults
import androidx.compose.material.Text
import androidx.compose.material.contentColorFor
import androidx.compose.material.primarySurface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.google.accompanist.pager.ExperimentalPagerApi
import com.google.accompanist.pager.HorizontalPager
import com.google.accompanist.pager.PagerState
import com.google.accompanist.pager.pagerTabIndicatorOffset
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.launch
import pl.planik.R
import pl.planik.app.LocalDateFormatter
import pl.planik.app.ui.theme.Gray100
import pl.planik.app.ui.theme.Gray800
import pl.planik.domain.model.Day
import pl.planik.domain.model.DayEntry
import pl.planik.presentation.common.Empty
import java.time.DayOfWeek

@ExperimentalFoundationApi
@Composable
fun PlanStickyHeadersList(
  listState: LazyListState,
  entries: List<Day>
) {
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
      Spacer(
        modifier = Modifier.height(dimensionResource(id = R.dimen.xBig))
      )
    }
  }
}

@ExperimentalPagerApi
@Composable
fun PlanPager(
  pagerState: PagerState,
  days: List<Day>,
  onDayChange: (dayOfWeek: DayOfWeek) -> Unit = {},
) {
  LaunchedEffect(pagerState) {
    snapshotFlow { pagerState.currentPage }
      .distinctUntilChanged()
      .collect { page ->
        onDayChange(days[page].dayOfWeek)
      }
  }

  Column(
    verticalArrangement = Arrangement.Top
  ) {
    PlanTabs(
      pagerState = pagerState,
      backgroundColor = MaterialTheme.colors.surface,
      days = days,
    )
    PlanTabsContent(
      pagerState = pagerState,
      days = days,
    )
  }
}

@ExperimentalPagerApi
@Composable
private fun PlanTabs(
  pagerState: PagerState,
  backgroundColor: Color = MaterialTheme.colors.primarySurface,
  contentColor: Color = contentColorFor(backgroundColor),
  days: List<Day>
) {
  val scope = rememberCoroutineScope()
  val localFormatter = LocalDateFormatter.current

  ScrollableTabRow(
    selectedTabIndex = pagerState.currentPage,
    edgePadding = 8.dp,
    backgroundColor = backgroundColor,
    contentColor = contentColor,
    indicator = { tabPositions ->
      TabRowDefaults.Indicator(
        Modifier.pagerTabIndicatorOffset(pagerState, tabPositions)
      )
    }
  ) {
    days.forEachIndexed { index, day ->
      Tab(
        selected = pagerState.currentPage == index,
        onClick = {
          scope.launch {
            pagerState.animateScrollToPage(index)
          }
        },
        text = {
          Text(
            localFormatter.formatDayName(day.date),
            style = MaterialTheme.typography.subtitle1.copy(fontWeight = FontWeight.Bold)
          )
        }
      )
    }
  }
}

@ExperimentalPagerApi
@Composable
private fun PlanTabsContent(
  pagerState: PagerState,
  days: List<Day>
) {
  HorizontalPager(
    count = days.size,
    state = pagerState,
    verticalAlignment = Alignment.Top,
  ) { page ->
    val entries = days[page].entries
    if (entries.isEmpty()) {
      Column(
        verticalArrangement = Arrangement.Center,
      ) {
        Empty()
      }
    } else {
      LazyColumn(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Top
      ) {
        items(days[page].entries) { dayEntry ->
          DayEntryItem(dayEntry)
        }
        item {
          Spacer(
            modifier = Modifier.height(dimensionResource(id = R.dimen.xBig))
          )
        }
      }
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
private fun DayEntryItem(dayEntry: DayEntry) {

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