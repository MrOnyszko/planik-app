import 'package:flutter/material.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/screens/plan/content/day_entries_list.dart';
import 'package:planik/presentation/screens/plan/content/day_entries_sticky_header_list.dart';

class PlanVertical extends StatelessWidget {
  const PlanVertical({
    required this.title,
    required this.days,
    required this.appBarActions,
    this.onItemTap,
    this.scrollController,
    this.applyTitlePadding = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Day> days;
  final List<Widget> appBarActions;
  final OnItemTap? onItemTap;
  final ScrollController? scrollController;
  final bool applyTitlePadding;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          centerTitle: false,
          elevation: 0,
          actions: appBarActions,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: applyTitlePadding
                ? const EdgeInsets.only(
                    left: Insets.xLarge,
                    bottom: Insets.large,
                  )
                : null,
            title: Text(title, style: context.theme.appBarTheme.titleTextStyle),
          ),
        ),
        ...days
            .map(
              (day) => DayEntriesStickyHeaderList(day: day, onItemTap: onItemTap),
            )
            .toList(),
      ],
    );
  }
}
